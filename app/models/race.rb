class Race < ApplicationRecord
  belongs_to :challenge
  belongs_to :user

  def wpm
    challenge.effective_words.to_f / time_in_minutes
  end

  def accuracy
    (1 - (mistakes.to_f / challenge.word_count)) * 100
  end

  def time_in_minutes
    time.to_f / 60000
  end

  def formatted_time
    seconds = (time.to_f / 1000) % 60
    minutes = (time.to_f / 60000).floor
    sprintf("%02d:%02d", minutes, seconds)
  end
end
