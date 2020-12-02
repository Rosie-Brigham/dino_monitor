# Not currently used... not sure why
# TODO - work out why this is not working!
class CSVCreateService
  def initialize(params)
    site = Site.find(params[:site_id])
    @submissions = site.submissions
  end

  def create
    CSV.generate(headers: true) do |csv|
      csv << attributes
      @submissions.each do |submission|
        csv << attributes.map do |attr|
          submission.send(attr)
        end
      end
    end
  end

  private
  
  def attributes
    %w{site_name type_name reliable record_taken}
  end
end
