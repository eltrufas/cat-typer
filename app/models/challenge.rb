class Challenge < ApplicationRecord
  after_create :generate
  belongs_to :prompt

  def generate
    PreGenerateRacesJob.perform_later(self)
  end
end
