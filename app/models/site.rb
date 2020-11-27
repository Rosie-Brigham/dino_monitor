class Site < ApplicationRecord
  has_many :site_records
  has_many :submissions, through: :site_records
  belongs_to :site_group
  
  UNSORTED_SITES = ['Instagram unsorted', 'Twitter unsorted', 'Unsuitable', 'Uploaded unsorted'].freeze
end