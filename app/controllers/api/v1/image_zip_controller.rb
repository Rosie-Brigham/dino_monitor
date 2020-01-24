require 'zip'
module Api
  module V1
    class ImageZipController < BaseController
      
      def get_images
        # Simulation of an object with has_many_attached :documents
        # job = Submission.all.map {|s| s.image.attachment }
        submissions = Submission.all
        # Tmp folder to store the download files from S3
        # Notice we prfix the folder with a unique number (current_user.id)
        tmp_user_folder = "tmp/archive_submissions"
       
        # Determin the length of the folder
        directory_length_same_as_documents = Dir["#{tmp_user_folder}/*"].length == submissions.length
        
        # Create a tmp folder if not exists
        FileUtils.mkdir_p(tmp_user_folder) unless Dir.exists?(tmp_user_folder)
        # Download and save documents to our tmp folder
        submissions.each do |submission|
          document = submission.image.attachment
          name = document.blob.filename.to_s
          year = submission.record_taken.strftime("%Y/")
          month = submission.record_taken.strftime("%m/")
          day = submission.record_taken.strftime("%d-")

          filename = day + name
          new_filename = year + month + filename
          # filename = document.blob.filename.to_s

          # User should be able to download files if not yet removed from tmp folder
          # if the folder is already there, we'd get an error
          create_tmp_folder_and_store_documents(document, tmp_user_folder, filename) unless directory_length_same_as_documents
          #---------- Convert to .zip --------------------------------------- #
          create_zip_from_tmp_folder(tmp_user_folder, filename, new_filename) unless directory_length_same_as_documents
        end
        # Sends the *.zip file to be download to the client's browser
        send_file(Rails.root.join("#{tmp_user_folder}.zip"), :type => 'application/zip', :filename => "Files_for_submissions.zip", :disposition => 'attachment')
        # TODO: Remove files at a later date
        # as zip file wont be able to downloads if uncommented
        # FileUtils.rm_rf([tmp_user_folder, "#{tmp_user_folder}.zip"])
      end

      def create_tmp_folder_and_store_documents(document, tmp_user_folder, filename)
        file = File.open(File.join(tmp_user_folder, filename), 'wb') do |file|
          # As per georgeclaghorn in comment ;)
          begin
            # binding.pry
          document.download { |chunk| file.write(chunk) }
          rescue Aws::S3::Errors::ServiceError
            puts 'BUGGER'
          end
        end
      end
      
      def create_zip_from_tmp_folder(tmp_user_folder, filename, new_filename)
        Zip::File.open("#{tmp_user_folder}.zip", Zip::File::CREATE) do |zf|
          zf.add(new_filename, "#{tmp_user_folder}/#{filename}")
        end
      end
    end
  end
end