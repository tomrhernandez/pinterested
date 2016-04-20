class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  # authenticate_user! will make sure the user is logged in, exceptions are index and show methods.
  before_action :authenticate_user!, except: [:index, :show]
  # correct_user will only allow the user who created the pin to edit, update, and destroy.
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /pins
  # GET /pins.json
  def index
    @pins = Pin.all
  end

  # GET /pins/1
  # GET /pins/1.json
  def show
  end

  # GET /pins/new
  def new
    # replaced this line @pin = Pin.new
    @pin = current_user.pins.build
  end

  # GET /pins/1/edit
  def edit
  end

  # POST /pins
  # POST /pins.json
  def create
    # replaced this line @pin = Pin.new(pin_params)
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
      render action 'new'
    end
  end

  # PATCH/PUT /pins/1
  # PATCH/PUT /pins/1.json
  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    @pin.destroy
    redirect_to pins_url
    end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image, :user_id)
    end
  
    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    end
