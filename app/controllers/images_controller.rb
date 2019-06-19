class ImagesController < ActionController::Base
  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.create(image_params)
    if @image.save
      redirect_to image_path(@image), notice: 'Image was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def image_params
    params.require(:image).permit(:url)
  end
end
