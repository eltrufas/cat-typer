class DictionariesController < ApplicationController
  before_action :set_dictionary, only: [:show]

  def show
    @sample = @dictionary.random_sample 20
  end

  private
  def set_dictionary
    @dictionary = Dictionary.find(params[:id])
  end
end
