class Dictionary < ApplicationRecord
  extend FriendlyId
  has_many :dictionary_words

  friendly_id :name, use: :slugged
  
  def random_sample(n)
    count = dictionary_words.count
    Array.new n do
      dictionary_words.offset(rand(count)).first.text
    end
  end

  def should_generate_new_friendly_id?
    name_changed?
  end
end
