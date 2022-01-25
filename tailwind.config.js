module.exports = {
  content: [
    "./app/components/**/*.rb",
    "./app/**/*.html.erb",
    "./app/javascript/**/*.js",
    "./app/javascript/**/*.ts",
  ],
  theme: {
    extend: {
      height: {
        104: "24rem",
        108: "26rem",
      },
    },
  },
  variants: {
    extend: {
      borderWidth: ["last"],
      margin: ["last"],
    },
  },
  plugins: [],
};
