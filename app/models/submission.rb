class Submission < ApplicationRecord
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  has_many :site_records
  has_many :sites, through: :site_records
  
  has_one :type,  :dependent => :destroy
  accepts_nested_attributes_for :type
  belongs_to :participant
  
  validate :validate_site_id
  validate :validate_participant_id
  validates_presence_of :record_taken

  has_one_attached :image
  # to get url for image when developing API - use s.image.service_url
  TYPE_NAMES = %w(EMAIL TWITTER WHATSAPP INSTAGRAM OTHER )

  scope :reliable, -> { where(reliable: true) }
  
  scope :exclude_unsorted, ->(id) { 
    where.not(site_id: id)
  }

  scope :search_site, ->(site_id) {
    if site_id.present?
      where(sites: site_id)
    end
  }

  scope :type_search, ->(type_name) {
    if type_name.present?
      type_name.upcase!
      where(type_name:  type_name)
    end
  }

  scope :with_tags, ->(tags) { 
    if tags.present?
      tags = tags.split(',')
      tagged_with(tags, any: true) 
    end
  }
  
  def site_names
    @site_name ||= sites.map(&:name)
  end

  def image_url
    Rails.application.routes.url_helpers.rails_blob_path(image.attachment, only_path: true)
  end
  
  def set_filename
    if self.image.attached?
      file_name = "#{self.record_taken.strftime("%d-%m-%Y")}_#{type_name.first.downcase}.jpg"
      self.image.blob.update(filename: file_name)
    end
  end
  private

  def validate_site_id
    errors.add(:site_ids, "site ids are missing or invalid") unless self.site_ids.map { |id| Site.exists?(id)} && site_ids.present?
  end

  def validate_participant_id
    errors.add(:participant_id, "participant is invalid or missing") unless Participant.exists?(self.participant_id)
  end
end