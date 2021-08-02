class PreGenerateRacesJob < ApplicationJob
  queue_as :default

  def perform(challenge)
    generated = text_generator.generate(challenge.prompt.body, 512)
    challenge.text = generated
    challenge.generated = true
    challenge.save
  end

  private
    def text_generator
      TextGenerator.new("http://95.217.114.54:8090")
    end
end
