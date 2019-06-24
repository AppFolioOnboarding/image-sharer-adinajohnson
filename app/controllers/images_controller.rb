class ImagesController < ApplicationController
  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to image_path(@image), notice: 'Image was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @images = if params[:tag]
                Image.tagged_with(params[:tag]).order(created_at: :desc)
              else
                @images = Image.order(created_at: :desc)
              end
  end

  private

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end
end
