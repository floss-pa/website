class CarouselsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_carousel, only: [:show, :edit, :update, :destroy]

  # GET /carousels
  # GET /carousels.json
  def index
    @carousels = Carousel.all
  end

  # GET /carousels/1
  # GET /carousels/1.json
  def show
  end

  # GET /carousels/new
  def new
    @carousel = Carousel.new
  end

  # GET /carousels/1/edit
  def edit
  end

  # POST /carousels
  # POST /carousels.json
  def create
    @carousel = current_user.carousels.new(carousel_params)

    respond_to do |format|
      if @carousel.save
        format.html { redirect_to @carousel, notice: 'Carousel was successfully created.' }
        format.json { render :show, status: :created, location: @carousel }
      else
        format.html { render :new }
        format.json { render json: @carousel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carousels/1
  # PATCH/PUT /carousels/1.json
  def update
    respond_to do |format|
      if @carousel.update(carousel_params)
        format.html { redirect_to @carousel, notice: 'Carousel was successfully updated.' }
        format.json { render :show, status: :ok, location: @carousel }
      else
        format.html { render :edit }
        format.json { render json: @carousel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carousels/1
  # DELETE /carousels/1.json
  def destroy
    @carousel.destroy
    respond_to do |format|
      format.html { redirect_to carousels_url, notice: 'Carousel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carousel
      @carousel = Carousel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carousel_params
      params.require(:carousel).permit(:user_id, :header, :sentence, :link, :image, :page_id, :active, :crop_x, :crop_y, :crop_x2, :crop_y2, :crop_w, :crop_h, :crop_vy)
    end
end
