class LeaguesController < ApplicationController
  before_filter :admin_user, only: [:new, :create, :edit, :update, :destroy]
  # before_filter :admin_user,     only: :destroy

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.all
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    @league = League.find(params[:id])
  end

  # GET /leagues/new
  # GET /leagues/new.json
  def new
    @league = League.new

    # respond_to do |format|
      # format.html # new.html.erb
      # f?ormat.json { render json: @league }
    # end
  end

  # GET /leagues/1/edit
  def edit
    @league = League.find(params[:id])
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
    @league = League.find(params[:id])

    if @league.save
      redirect_to @league, notice: 'League was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league = League.find(params[:id])
    @league.destroy

    redirect_to leagues_url
  end
  
end
