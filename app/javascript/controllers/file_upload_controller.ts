import { Controller } from "@hotwired/stimulus";
import { URLConfig, CloudConfig, CloudinaryImage } from "@cloudinary/url-gen";
import Dropzone from "dropzone";
import "dropzone/dist/dropzone.css";

export default class extends Controller {
  static targets = ["upload", "images", "deleteImages", "form"];

  static values = {
    pid: String,
    apikey: String,
    cloudname: String,
    folder: String,
    timestamp: Number,
    signature: String,
  };

  declare formTarget: HTMLFormElement;
  declare uploadTarget: HTMLDivElement;
  declare imagesTarget: HTMLInputElement;
  declare deleteImagesTarget: HTMLInputElement;

  declare pidValue: string;
  declare apikeyValue: string;
  declare cloudnameValue: string;
  declare folderValue: string;
  declare timestampValue: number;
  declare signatureValue: string;

  private count: number = 0;
  private imageUploadMap: Map<string, string> = new Map();
  private imageDeleteSet: Set<string> = new Set();

  connect() {
    this.initDropZone();
  }

  submit(event: Event): void {
    event.preventDefault();

    this.imagesTarget.value = [...this.imageUploadMap.values()].join(",");
    this.deleteImagesTarget.value = [...this.imageDeleteSet].join(",");
    this.formTarget.submit();
  }

  initDropZone(): void {
    const myDropzone = new Dropzone(this.uploadTarget, {
      acceptedFiles: ".jpg,.png,.jpeg,.gif",
      addRemoveLinks: true,
      maxFiles: 20,
      maxFilesize: 5242880, // 5MB in bytes
      renameFile: () => this.renameFile(),
      url: `https://api.cloudinary.com/v1_1/${this.cloudnameValue}/auto/upload`,
    });

    this.listeners(myDropzone);
    this.setupImageUploadMap(myDropzone);
  }

  setupImageUploadMap(dropzone): void {
    if (this.imagesTarget.value) {
      const publicIds: string[] = this.imagesTarget.value.split(",");

      publicIds.forEach((publicId) => {
        const fileName = this.getFileName(publicId);
        this.imageUploadMap.set(fileName, publicId);
        this.renderUploadedImage(dropzone, fileName, publicId);
      });
    }
  }

  renderUploadedImage(dropzone, fileName, publicId): void {
    const cloudConfig = new CloudConfig({ cloudName: this.cloudnameValue });
    const urlConfig = new URLConfig({ secure: true });
    const image = new CloudinaryImage(publicId, cloudConfig, urlConfig);
    const imageUrl = image.toURL();

    const callback = null;
    const crossOrigin = "same-site";
    const resizeThumbnail = true;

    dropzone.displayExistingFile(
      { name: fileName },
      imageUrl,
      callback,
      crossOrigin,
      resizeThumbnail
    );
  }

  getFileName(source): string {
    const imageUrl = source.split("/")[1];
    const imageUrlParts = imageUrl.split("_");
    return `${imageUrlParts[0]}_${imageUrlParts[1]}`;
  }

  renameFile(): string {
    this.count += 1;
    const count = this.count >= 10 ? this.count : `0${this.count}`;

    return `${this.pidValue}_${count}`;
  }

  listeners(dropzone): void {
    dropzone.on("sending", (file, xhr, formData) =>
      this.onSending(file, xhr, formData)
    );

    dropzone.on("success", (file, response) => this.onSuccess(file, response));
    dropzone.on("removedfile", (file) => this.onRemovedFile(file));
  }

  onSending(file, xhr, formData): void {
    formData.append("api_key", this.apikeyValue);
    formData.append("timestamp", this.timestampValue);
    formData.append("folder", this.folderValue);
    formData.append("signature", this.signatureValue);
    formData.append("use_filename", true);
  }

  onSuccess(file, response): void {
    const { original_filename, public_id } = response;
    this.imageUploadMap.set(original_filename, public_id);
  }

  onRemovedFile(file): void {
    const fileName = file.upload ? file.upload.filename : file.name;
    const publicId = this.imageUploadMap.get(fileName);
    this.imageDeleteSet.add(publicId);
    this.imageUploadMap.delete(fileName);
  }
}
