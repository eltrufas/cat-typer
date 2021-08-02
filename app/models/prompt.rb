class Prompt < ApplicationRecord
  after_create :generate_initial_challenges
  has_many :challenges

  def generate_challenge
      challenges.create
  end

  def generate_initial_challenges
    arr = Array.new(100) do {}; end
    challenges.create arr
  end

  def generated_challenges
    challenges.where({:generated => true})
  end
end
