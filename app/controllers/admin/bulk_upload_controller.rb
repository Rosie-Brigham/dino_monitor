
class Admin::BulkUploadController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]
  before_action :redirect_unless_admin

  def index
  end

  def create
    if params[:file].present?
      results = bulk_upload_images
      respond_to do |format|
        format.html { redirect_to admin_submissions_url }
        format.json { render json: results }
      end
    else
      flash[:notice] = 'Make sure you include some pictures!'
      redirect_back(fallback_location: admin_bulk_upload_index_path)
    end
  end

  private

  def permitted_params
    params.permit(:site_ids,
                  :reliable, 
                  :record_taken, 
                  :submitted_at,
                  :type_name, 
                  :participant_id,
                  :comment)
  end

  # TODO - work out if this should be somewhere else?
  def bulk_upload_images
    submissions = []
    params[:file].each do |key, image|
      site_params = params[:site_ids].split(',') if params[:site_ids].present?
      registration_params = permitted_params.merge(site_ids: site_params).merge(image: image)
      @registration = Registration.new(registration_params)
      # binding.pry
      if @registration.save
        submissions << "Image number #{key.to_i + 1}, upload sucessful"
      else
        submissions << "Image number #{key.to_i + 1}, upload unsucessful: #{@registration.errors.messages}"
      end
    end
    submissions
  end
end