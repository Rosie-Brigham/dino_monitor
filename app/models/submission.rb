class Submission < ApplicationRecord
  belongs_to :site
  has_one :type,  :dependent => :destroy
  accepts_nested_attributes_for :type
  
  validate :validate_site_id
  validates_presence_of :record_taken

  has_one_attached :image
  # to get url for image when developing API - use s.image.service_url

  scope :reliable, -> { where(reliable: true) }


  
  def type_name
    @type_name ||= type.present? ? type.name : ""
  end

    def site_name
    @site_name ||= site.name
  end
  
  private

  def validate_site_id
    errors.add(:site_id, "site id is invalid") unless Site.exists?(self.site_id)
  end
end