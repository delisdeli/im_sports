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

  def add_location
    loc = Location.get_by_name(params[:new_location])
    if @division.locations.exists?(loc)
      msg = "Division already contains that location."
    else
      @division.locations << loc
      @division.replace_fake_location(loc)
      msg = "Location was successfully added."
    end
    redirect_to [@league, @division], notice: msg
  end

  def remove_location
    @division = Division.find(params[:id])
    loc = Location.find_by_id(params[:location_id])
    @division.restore_fake_location(loc)
    @division.locations.delete(loc)
    if (loc.divisions.count == 0)
        loc.destroy
    end
    redirect_to [@league, @division], notice: "Location was successfully removed."
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
