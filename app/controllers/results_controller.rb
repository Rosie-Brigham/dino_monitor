class ResultsController < ApplicationController
  DATE = '01/09/2018'.to_date

  def index
    @type_numbers = create_type_numbers_array
    @site_numbers = create_site_numbers
  end
  


  private

  def create_type_numbers_array
    Type::NAMES.map do |name|
      Submission.joins(:type).where(types: { name: name }).count
    end
  end

  def create_site_numbers
    Site.all.map do |site|
      {
        name: site.name, 
        submissions: site.submissions.count,
        twitter: site.submissions.joins(:type).where(types: { name: "TWITTER" }).count,
        instagram: site.submissions.joins(:type).where(types: { name: "INSTAGRAM" }).count,
        email: site.submissions.joins(:type).where(types: { name: "EMAIL" }).count,
        whatsapp: site.submissions.joins(:type).where(types: { name: "WHATSAPP" }).count
      }
    end
  end
end
