class Challenge < ApplicationRecord
  after_create :generate
  belongs_to :prompt

  def generate
    PreGenerateRacesJob.perform_later(self)
  end

  def tokens
    text.gsub(/[\s\u00A0]+/m, ' ').strip.split(" ")
  end

  def effective_words
    tokens.reduce(0.0) do |sum, token|
      sum + (token.length.to_f / 5).ceil
    end
  end

  def word_count
    tokens.length
  end

  def preamble
    body = prompt.body
    if body.length < 240
      body
    else
      preamble = "..." + prompt.body.last(240)
    end
  end
end
