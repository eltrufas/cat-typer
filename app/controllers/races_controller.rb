class RacesController < ApplicationController
  before_action :set_prompt

  def new
    @challenge = @prompt.random_challenge
    @race = Race.new
  end
  
  def complete
    @challenge = Challenge.find(race_params[:challenge_id])
    @race = Race.new race_params
    if user_signed_in?
      @race.user_id = current_user.id
      @race.save
      current_user.recalculate_stats
      current_user.save
    end

    # Mark challenge as used so it doesn't show up again
    @challenge.used = true
    @challenge.save

    # Replace existing challenge with new generated challenge
    @prompt.generate_challenge


    @stats = {:wpm => params[:wpm], :time => params[:time], :accuracy => params[:accuracy]}
  end

  private
  def set_prompt
    @prompt = Prompt.find(params[:prompt_id])
  end

  def race_params
    params.require(:race).permit(:time, :mistakes, :challenge_id)
  end
end
