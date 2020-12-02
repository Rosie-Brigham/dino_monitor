class SiteRecord < ApplicationRecord
  belongs_to :site
  belongs_to :submission
end