# frozen_string_literal: true

class SubmissionsDataCreateService
  def initialize(submissions, date)
    @submissions = submissions
    @date = date
  end

  def create
    participants = Participant.where('first_submission >= ?', @date)
    {
      byMonth: create_date_hash(@submissions, @date, 'record_taken'),
      participantsByMonth: create_date_hash(participants, @date, 'first_submission'),
      totalParticipants: Participant.count,
      aiTags: ai_tags_object, # WHY IS THIS A DIFFERENT CASE!
      types: types_object,
      maxSubs: top_scores_object,
      minSubs: bottom_scores_object
    }
  end

  private

  def create_date_hash(collection, date, column)
    date_hash = Hash[(0..12).collect { |n| [date.advance(months: n).strftime('%m/%y'), 0] }]
    collection_by_months = collection.group("TO_CHAR(#{column}, 'MM/YY')").count.sort

    date_hash.map do |k, _v|
      { x: k, y: collection_by_months.to_h[k] || 0 }
    end
  end

  def types_object
    Submission.select(:type_name).group(:type_name).size.map { |name, number| { x: name.capitalize, y: number } }
  end

  def ai_tags_object
    # get all the tags and their values
    # binding.pry
    tags = @submissions.select(:ai_tags).map { |t| t[:ai_tags] }.flatten
    # create new hash
    new = {}
    # flatten them down into one object

    tags.each do |hash|
      # Hacky hack - due to incorrect migration - needs to be sorted!!
      next if hash == '{}'

      hash.map do |text, value|
        if new[text]
          new[text][:count] += 1
          new[text][:value] << value.round(2)
        else
          new[text] = { count: 1, value: [value.round(2)] }
        end
      end
    end

    # get the mean score for certaintly
    new.map do |label|
      array = label[1][:value]
      mean = array.inject { |sum, el| sum + el }.to_f / array.size
      label[1][:value] = mean.round(2)
    end

    # make it into another new object, coz why on earth not...
    final = []
    new.map { |label| final << { label: label[0], x: label[1][:value], y: label[1][:count] } }
    # return the final array
    # I KNOW THIS IS AWFUL BUT I HAVE A DEADLINE. DON'T JUDGE ME!
    # sort them and get the last 100
    final.sort_by { |obj| obj[:y] }.last(70)
  end

  def top_scores_object
    scores.first(4).map(&:site_names).flatten.uniq
  end
  
  def bottom_scores_object
    scores.last(4).map(&:site_names).flatten.uniq
  end

  def scores
    @scores ||= Submission.left_joins(:sites).group(:id).order('COUNT(sites.id) DESC')
  end
end
