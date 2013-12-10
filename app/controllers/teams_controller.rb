class TeamsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_filter :set_league, except: [:dismiss_invite, :add_member]
  before_filter :set_division, except: [:dismiss_invite, :add_member]
  before_filter :set_team, except: [:index, :new, :create]
  # GET /teams
  # GET /teams.json
  def index
    @teams = @division.teams.where(:placeholder=>false)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  def invite
    begin
      @user = User.find_by_email(params[:to_invite])
    rescue
    end
    unless @user
      redirect_to [@league, @division, @team], notice: "That user doesn't exist"
      return
    end
    invitation = Invitation.new('user' => @user, 'team' => @team)
    @team.invitations << invitation
    @user.invitations << invitation
    flash[:notice] = "#{@user.email} has been invited."
    redirect_to [@league, @division, @team]
  end 

  def add_member
    begin
      @user = User.find_by_id(params[:user_id])
    rescue
    end
    unless @user
      redirect_to root_url, notice: "That user doesn't exist"
      return
    end
    begin
      @invite = Invitation.find_by_id(params[:invite_id])
    rescue
    end
    unless @invite
      redirect_to @user, notice: "That invitation doesn't exist"
      return
    end
    @team.users << @user
    @user.invitations.delete(@invite)
    redirect_to @user, notice: "Successfully joined #{@team.name}"
  end

  def dismiss_invite
    begin
      @user = User.find_by_id(params[:user_id])
    rescue
    end
    unless @user
      redirect_to root_url, notice: "That user doesn't exist"
      return
    end
    begin
      @invite = Invitation.find_by_id(params[:invite_id])
    rescue
    end
    unless @invite
      redirect_to @user, notice: "That invitation doesn't exist"
      return
    end
    @invite.destroy
    redirect_to @user, notice: "Successfully dismissed invite."
  end

  # POST /teams
  # POST /teams.json
  def create
    params[:team][:placeholder] = false
    @team = Team.new(params[:team])

    if @team.save
      @division.teams << @team
      @team.users << current_user
      @division.replace_fake_team(@team)
      redirect_to [@league, @division, @team], notice: 'Team was successfully created.' 
    else
      render action: "new"
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    if @team.update_attributes(params[:team])
      redirect_to [@league, @division, @team], notice: 'Team was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    if current_user.admin? or current_user?(User.find_by_email(@team.captain_email))
      @division.restore_fake_team(@team)
      @team.destroy
    else
      flash[:notice] = "You are not authorized to access this function"
    end
    redirect_to league_division_teams_url
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

    def set_team
      begin
        @team = Team.find(params[:id])
      rescue
      end
      redirect_to root_url, notice: "That team doesn't exist" unless @team
    end
end
