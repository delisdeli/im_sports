class DivisionsController < ApplicationController
  before_filter :admin_user, except: [:show]
  before_filter :set_league
  before_filter :set_division, except: [:new, :create]

  # GET /divisions/1
  # GET /divisions/1.json
  def show
    if params[:gameday_shown]
      p params[:gameday_shown]
      @gameday = Date.parse(Time.parse(params[:gameday_shown]).utc.to_s)
    else
      @gameday = @division.this_weeks_gameday
    end

    if params[:update_schedule] == "prev"
      @gameday = @division.prev_gameday(@gameday)
    elsif params[:update_schedule] == "next"
      @gameday = @division.next_gameday(@gameday)
    end
    p @gameday
    @games_to_show = @division.get_weeks_games(@gameday)
    p @games_to_show
  end

  # GET /divisions/new
  # GET /divisions/new.json
  def new
    @division = Division.new
  end

  # GET /divisions/1/edit
  def edit
  end

  # POST /divisions
  # POST /divisions.json
  def create
    @division = Division.new(params[:division])

    if @division.save
      @league.divisions << @division
      redirect_to [@league, @division], notice: 'Division was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /divisions/1
  # PUT /divisions/1.json
  def update
    if @division.update_attributes(params[:division])
      redirect_to [@league, @division], notice: 'Division was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /divisions/1
  # DELETE /divisions/1.json
  def destroy
    @division.destroy
    
    redirect_to league_path @league
  end

  private
    def set_league
      @league = League.find_by_id(params[:league_id])
    end

    def set_division
      @division = Division.find(params[:id])
    end
end
