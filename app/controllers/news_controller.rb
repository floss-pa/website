class NewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index,:show]
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /news
  # GET /news.json
  def index
    @news = News.paginate(:page => params[:page],:per_page =>9 ).where("publish=true ", params[:id]).order('created_at DESC')

  end

  # GET /news/1
  # GET /news/1.json
  def show
    set_meta_tags og: {
                  url: "#{request.base_url + request.original_fullpath}",
                  type: "website",
                  title: "#{@news.title} Software Libre y Codigo Abierto Panama",
                  description: @news.news_content.content,
                  site_name: "floss-pa",
                  image: "https://floss-pa.net/images/logo.png}"
                  }
    set_meta_tags twitter: {
                card:  "summary",
                description: @news.news_content.content,
                title: @news.title,
                creator: "@flosspa",
                image: {
                        _:       "https://floss-pa.net/images/logo.png}",
                        width:  100,
                        height: 100,
                },
                domain: "Floss-pa"
                }


    set_meta_tags  author: user_custom_path(@news.user,@news.user.name.gsub(/\s/,'-'))
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  # POST /news.json
  def create
    @news = current_user.news.new(news_params)

    respond_to do |format|
      if @news.save
        format.html { redirect_to @news, notice: 'News was successfully created.' }
        format.json { render :show, status: :created, location: @news }
      else
        format.html { render :new }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to @news, notice: 'News was successfully updated.' }
        format.json { render :show, status: :ok, location: @news }
      else
        format.html { render :edit }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to news_index_url, notice: 'News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:title, :keywords, :language, :publish, :published_at, news_content_attributes: [:id,:content,:bootsy_image_gallery_id])
    end
end
