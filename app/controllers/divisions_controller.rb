class DivisionsController < ApplicationController
  before_filter :admin_user, except: [:index, :show]
  before_filter :set_league

  # GET /divisions/1
  # GET /divisions/1.json
  def show
    @division = Division.find(params[:id])
  end

  # GET /divisions/new
  # GET /divisions/new.json
  def new
    @division = Division.new
  end

  # GET /divisions/1/edit
  def edit
    @division = Division.find(params[:id])
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
    @division = Division.find(params[:id])

    if @division.update_attributes(params[:division])
      redirect_to [@league, @division], notice: 'Division was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /divisions/1
  # DELETE /divisions/1.json
  def destroy
    @division = Division.find(params[:id])
    @division.destroy
    
    redirect_to league_path @league
  end

  private
    def set_league
      @league = League.find_by_id(params[:league_id])
    end
end
