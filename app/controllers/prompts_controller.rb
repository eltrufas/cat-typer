class PromptsController < ApplicationController
  def index
    @prompts = Prompt.all
  end
end
