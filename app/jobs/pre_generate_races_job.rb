class PreGenerateRacesJob < ApplicationJob
  queue_as :default

  def perform(challenge)
    generated = text_generator.generate(challenge, 80)
    challenge.text = generated
    challenge.generated = true
    challenge.save
  end

  private
    def text_generator
      TextGenerator.new(
        "https://api-inference.huggingface.co",
        Rails.application.credentials.huggingface[:token],
      )
    end
end
