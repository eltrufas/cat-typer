class ChallengesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def webhook
    params.require([:challenge_id, :text])
    challenge = Challenge.find(params[:challenge_id])
    challenge.text = params[:text]
    challenge.generated = true
    challenge.save
  end
end
