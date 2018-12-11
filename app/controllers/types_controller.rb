class TypesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :set_type, only: [:show, :edit, :update, :destroy]
  
  def index
    @types = smart_listing_create(:types, Type.all, partial: "types/listing")
  end
  
  def new
    @type = Type.new
  end

  def create
    @type = Type.new(type_params)
  end

  def update
    @type.update_attributes(type_params)
  end

  def destroy
    @type.destroy
  end

  private
  def set_type
    @type = Type.find(params[:id])
  end

  def type_params
    params.require(:type).permit(:id, :name, :data)
  end
end