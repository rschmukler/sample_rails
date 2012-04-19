class TalksController < ApplicationController
  def index
    @talks = Talk.all
  end

  def new
    @talk = Talk.new
  end

  def create
    @talk = Talk.new(params[:talk])
    if @talk.save
      flash[:notice] = "Successfully added talk!"
      redirect_to talks_path
    else
      flash[:alert] = "Invalid talk. Please check and try again!"
      render 'new'
    end
  end

  def destroy
    Talk.destroy(params[:id])
    flash[:alert] = "Talk successfully destroyed!"
    redirect_to talks_path
  end

  def vote
    if session[:voted]
      flash[:alert] = "Sorry you've already voted. Thanks though!"
    else
      flash[:notice] = "Vote successfully counted!"
      Talk.find(params[:talk_id]).cast_vote!
      session[:voted] = true
    end
    redirect_to talks_path
  end

end
