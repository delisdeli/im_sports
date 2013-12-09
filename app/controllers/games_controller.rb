class GamesController < ApplicationController
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]
  before_filter :set_league
  before_filter :set_division
  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
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
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      redirect_to [@league, @division, @game], notice: "Game was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to [@league, @division]
  end

  private
    def set_league
      @league = League.find_by_id(params[:league_id])
    end

    def set_division
      @division = Division.find_by_id(params[:division_id])
    end
end
