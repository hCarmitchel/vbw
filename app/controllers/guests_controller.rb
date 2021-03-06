class GuestsController < ApplicationController
  before_action :set_guest, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /guests
  # GET /guests.json
  def index
    @guests = Guest.all
    @users = User.all
  end

  # GET /guests/1
  # GET /guests/1.json
  def show
  end

  # GET /guests/new
  def new
    @guest = Guest.new
  end

  # GET /guests/1/edit
  def edit
  end

  # POST /guests
  # POST /guests.json
  def create
    @guest = Guest.new(guest_params)

    respond_to do |format|
      if @guest.save
        redirect_url = current_user.admin? ? guests_url : edit_user_registration_path
        format.html { redirect_to redirect_url, notice: 'Guest was successfully created.' }
        format.json { render :show, status: :created, location: @guest }
      else
        format.html { render :new }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guests/1
  # PATCH/PUT /guests/1.json
  def update
    respond_to do |format|
      if @guest.update(guest_params)
        redirect_url = current_user.admin? ? guests_url : edit_user_registration_path
        format.html { redirect_to redirect_url, notice: 'Guest was successfully updated.' }
        format.json { render :show, status: :ok, location: @guest }
      else
        format.html { render :edit }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest.destroy
    redirect_url = current_user.admin? ? guests_url : edit_user_registration_path
    respond_to do |format|
      format.html { redirect_to redirect_url, notice: 'Guest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_guest
    @guest = Guest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def guest_params
    params['guest']['user_id'] = current_user.id
    params['guest'].permit(:last_name, :first_name, :food_preference, :user_id,
      :below_drinking_age, :role, :hotel, :allergy)
  end
end
