require 'faraday'
require 'faraday_middleware'

class TextGenerator
  def initialize(host, token)
    @host = host
    @token = token
  end

  def generate(challenge, max_length)
    response = http_client.post(
      '/models/gpt2-large',
      {
        :inputs => challenge.prompt.body,
        :parameters => {
          :max_new_tokens => max_length,
          :return_full_text => false,
        },
        :options => {
          :use_cache => false,
        },
      },
    )
    puts(response.status)

    return response.body[0]["generated_text"]
  end

  private
  def http_client
    Faraday.new(
      url: @host,
      headers: {
        "Content-Type" => "application/json",
        "Authorization" => @token,
      }
    ) do |f|
      f.request :json
      f.response :json
    end
  end
end
