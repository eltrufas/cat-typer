require 'faraday'

class TextGenerator
  def initialize(host)
    @host = host
  end

  def generate(prompt, max_length)
    response = http_client.post(
      '/generate-text',
      JSON.dump({:prompt => prompt, :max_length => max_length}),
    )
    return JSON.parse(response.body)
  end

  private
  def http_client
    Faraday.new(
      url: @host,
      headers: {'Content-Type' => 'application/json'}
    )
  end
end
