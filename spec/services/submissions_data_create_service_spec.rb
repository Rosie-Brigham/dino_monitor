# frozen_string_literal: true

require 'rails_helper'
RSpec.describe SubmissionsDataCreateService do
  describe '#create' do
    before do
      Timecop.freeze(Time.local('2020/9/1'))
    end
  
    let(:participant) { create(:participant, first_submission: Date.today)}
    let(:participant_two) { create(:participant, first_submission: Date.today - 1.month)}
    let!(:sub_one) { create(:submission, participant_id: participant.id) }
    let!(:sub_two) { create(:submission, participant_id: participant_two.id, record_taken: Date.today - 1.month) }

    subject { described_class.new(Submission.all, Date.today - 1.year) }

    let(:expected_object) do
      { byMonth: [{ x: '01/19', y: 0 },
                  { x: '02/19', y: 0 },
                  { x: '03/19', y: 0 },
                  { x: '04/19', y: 0 },
                  { x: '05/19', y: 0 },
                  { x: '06/19', y: 0 },
                  { x: '07/19', y: 0 },
                  { x: '08/19', y: 0 },
                  { x: '09/19', y: 0 },
                  { x: '10/19', y: 0 },
                  { x: '11/19', y: 0 },
                  { x: '12/19', y: 1 },
                  { x: '01/20', y: 1 }],
        participantsByMonth: [{ x: '01/19', y: 0 },
                              { x: '02/19', y: 0 },
                              { x: '03/19', y: 0 },
                              { x: '04/19', y: 0 },
                              { x: '05/19', y: 0 },
                              { x: '06/19', y: 0 },
                              { x: '07/19', y: 0 },
                              { x: '08/19', y: 0 },
                              { x: '09/19', y: 0 },
                              { x: '10/19', y: 0 },
                              { x: '11/19', y: 0 },
                              { x: '12/19', y: 1 },
                              { x: '01/20', y: 1 }],
        totalParticipants: 2,
        aiTags: [],
        types: [{ x: 'Email', y: 2 }],
        maxSubs: ['Some Stones'],
        minSubs: ['Some Stones'] }
    end


    after do
      Timecop.return
    end

    it 'creates this object' do
      expect(subject.create).to eq expected_object
    end
  end
end
