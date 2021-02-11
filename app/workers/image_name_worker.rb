class ImageNameWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(submission_id)
    submission = Submission.find(submission_id)
    return unless submission&.image&.attached?
    submission.set_filename
    submission.save!
    Rails.logger.info "Changed name for #{submission.id}"
  end
end