class HomeController < ApplicationController
  def index
   @games = Game.where(:status_cd => Game.Active)
   @pending = Game.where(:status_cd => Game.Pending)
   @hosted = Game.where(:host_id => current_user.player.id, :status_cd => [Game.Active, Game.Pending])
   @youractive = Game.includes(:signups).where(:status_cd => Game.Active).joins(:signups).where(:signups => {:player_id => current_user.player.id})
   @yourpending = Game.includes(:signups).where(:status_cd => Game.Pending).joins(:signups).where(:signups => {:player_id => current_user.player.id})
   #Signup.where(:player_id => current_user.player.id).joins(:games).where(:games => {:status_cd => Game.Active})
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end
end