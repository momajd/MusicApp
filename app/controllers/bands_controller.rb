class BandsController < ApplicationController
  #If user isn't logged in, only allow them to see the index
  before_action :require_user!, except: [:index]

  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new #dummy band
    render :new
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      redirect_to band_url(@band)
    else
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])

    if @band.update_attributes(band_params)
      redirect_to band_url(@band)
    else
      #flash.now[:errors] @band.errors.full_messages #not working??
      render :edit
    end
  end

  def destroy
    band = Band.find(params[:id])
    band.destroy
    redirect_to :index
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end

  def require_user!
    return if current_user
    redirect_to new_session_url
  end
end
