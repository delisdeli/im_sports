class LeaguesController < ApplicationController
before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]
before_filter :set_league, except: [:index, :new, :create]

  # GET /leagues
  # GET /leagues.json
  def index
    @sports = League.sports
    if params[:sport_selected]
      @sport_selected = params[:sport_selected]
      @leagues = League.where(:sport => @sport_selected)
    else
      @leagues = League.all
    end
    if params[:league_selected]
      begin
        @league_selected = League.find_by_id(params[:league_selected])
      rescue
      end
      unless @league_selected
        redirect_to root_url, notice: "That league doesn't exist"
        return
      end
      @league_divisions = @league_selected.sorted_divisions
      if @league_divisions.nil? or @league_divisions.empty?
        @divisions_rows = 0
      else
        @divisions_rows = @league_divisions.values.map {|x| x.length}.max - 1
      end
    end
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
  end

  # GET /leagues/new
  # GET /leagues/new.json
  def new
    @league = League.new
    if params[:new_sport]
      @new_sport = true
    end
  end

  # GET /leagues/1/edit
  def edit
  end

  # POST /leagues
  # POST /leagues.json
  def create
    @league = League.new(params[:league])

    if @league.save
      redirect_to @league, notice: 'League was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /leagues/1
  # PUT /leagues/1.json
  def update
    if @league.update_attributes(params[:league])
      # Handle a successful update.
      redirect_to @league, notice: 'League was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league.destroy
    redirect_to leagues_url
  end
  
  def set_league
    begin
      @league = League.find(params[:id])
    rescue
    end
    redirect_to root_url, notice: "That league doesn't exist" unless @league
  end
end
