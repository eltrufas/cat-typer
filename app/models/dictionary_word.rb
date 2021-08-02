class DictionaryWord < ApplicationRecord
  belongs_to :dictionary
  class << self
    def random_sample(n)
      count = all.count
      Array.new n do
        all.offset(rand(count)).first.text
      end
    end
  end
end
