require 'uri'

class Registration
  include ActiveModel::Model

  attr_accessor :reliable, :site_ids, :image, :image_file, :record_taken, :submitted_at, :type_name, :participant_id, :type_specific_id, :comment

  def save
    return false if invalid?
    ActiveRecord::Base.transaction do
      participant = find_or_create_participant(participant_id)
      participant.update(first_submission: record_taken) if participant.first_submission.nil?
      submission = Submission.create!(site_ids: site_ids,
                                      participant_id: participant.id, 
                                      reliable: reliable, 
                                      record_taken: record_taken, 
                                      submitted_at: submitted_at, 
                                      type_name: type_name,
                                      comment: comment,
                                      type_specific_id: type_specific_id,
                                      image: image)

                                      # For twitter and insta uploads, using image URL
      save_image(submission, image_file, type_name) if image_file.present?

      submission.set_filename unless image_file.present? 
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    # Handle exception that caused the transaction to fail
    # e.message and e.cause.message can be helpful
    errors.add(:base, e.message)
    false
  end

  private

  def save_image(submission, image_file, type_name)
    image_name = "#{submission.record_taken.strftime("%d/%m/%Y")}_#{type_name.first.downcase}.jpg"
    begin
      file = URI.open(image_file)
      submission.image.attach(io: file, filename: image_name)
    rescue OpenURI::HTTPError => e
      puts "image is buggered"
      errors.add(:base, e.message)
      false
    end
  end

  def find_or_create_participant(participant_id)
    raise ActiveRecord::Rollback unless participant_id
    anonymised_id = encrypt(participant_id)
    participant = Participant.find_by(participant_id: anonymised_id)
    participant.present? ? participant : Participant.create!(participant_id: participant_id)
  end
    
  def encrypt(data)
    Digest::SHA1.hexdigest data
  end  
end