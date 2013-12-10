class GamesController < ApplicationController
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]
  before_filter :set_league
  before_filter :set_division
  before_filter :set_game, except: [:new, :create]
  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])
    if @game.save
      @division.games << @game
      redirect_to [@league, @division, @team], notice: "Game was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    if @game.update_attributes(params[:game])
      redirect_to [@league, @division, @game], notice: "Game was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    redirect_to [@league, @division]
  end

  private
    def set_league
      begin
        @league = League.find_by_id(params[:league_id])
      rescue
      end
      redirect_to root_url, notice: "That league doesn't exist" unless @league
    end

    def set_division
      begin
        @division = Division.find_by_id(params[:division_id])
      rescue
      end
      redirect_to root_url, notice: "That division doesn't exist" unless @division
    end

    def set_game
    begin
      @game = Game.find(params[:id])
    rescue
    end
    redirect_to root_url, notice: "That game doesn't exist" unless @game
    end 
end
