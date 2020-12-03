class SiteGroup < ApplicationRecord
  has_many :sites
  has_many :submissions, through: :sites
end