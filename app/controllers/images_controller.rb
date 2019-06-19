class ImagesController < ActionController::Base
  def new
    @image = Image.new
  end

end
