class PropertiesController < ApplicationController
  def index
    @properties = Property.all.order(created_at: :asc)
  end

  def show
    @property = Property.find_by!(id: params[:id])
  end
end
