class TeamsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_filter :set_league
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(params[:team])

    if @team.save
      @league.teams << @team
      redirect_to [@league, @team], notice: 'Team was successfully created.' 
    else
      render action: "new"
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    if @team.update_attributes(params[:team])
      redirect_to [@league, @team], notice: 'Team was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to league_teams_url
  end

  private
    def set_league
      @league = League.find_by_id(params[:league_id])
    end
end
