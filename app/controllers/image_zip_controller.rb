require 'zip'
class ImageZipController < ApplicationController
  #  TODO - work on this
  TMP_ARCHIVE_FOLDER_BASE = "tmp/archive_submissions".freeze
  
  def zip_images
    delete_current_tempfile # does this work on AWS?
    SubmissionZipWorker.perform_async(site_id, email_address, tmp_archive_dir)
    redirect_back(fallback_location: results_path, notice: 'Job started, images will be emailed when finished')
  end

  def download_zip
    # return folder for previously zipped folders
    # if Dir.exists?(TMP_ARCHIVE_FOLDER) && Dir.exists?(tmp_archive_dir)
    #   flash[:notice] = 'Zip file downloading'
    #   send_file(Rails.root.join("#{TMP_ARCHIVE_FOLDER}.zip"), :type => 'application/zip', :filename => "submissions.zip", :disposition => 'attachment')
    # else
    #   flash[:notice] = "Zip folder not present, you need to create it using zip create and download"
    # end
  end
  private
  
  def site_id
    @site_id ||= permitted_params[:site_id]
  end

  def email_address
    permitted_params[:email].present? ? permitted_params[:email] : ENV["DESIGNATED_EMAIL"]
  end

  def tmp_archive_dir
    # returns tmp/archive_submissions_6 for site ID 6
    "#{TMP_ARCHIVE_FOLDER_BASE}_#{site_id}"
  end

  def permitted_params
    params.permit(:site_id, :email)
  end

  def delete_current_tempfile
    # delete both archive folder and contents
    if Dir.exists?(tmp_archive_dir)
      FileUtils.rm_rf(Dir["#{tmp_archive_dir}/*"]) 
      FileUtils.rm_rf(Dir["#{tmp_archive_dir}"]) 
    end
  end
end
