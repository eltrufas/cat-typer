class Prompt < ApplicationRecord
  after_create :generate_initial_challenges
  has_many :challenges

  def generate_challenge
      challenges.create
  end

  def generate_initial_challenges
    arr = Array.new(10) do {}; end
    challenges.create arr
  end

  def generated_challenges
    challenges.where({:generated => true})
  end

  def unused_challenges
    challenges.where({:generated => true, :used => false})
  end

  def random_challenge
    chal_count = unused_challenges.count
    return unused_challenges.offset(rand(chal_count)).first
  end
end
