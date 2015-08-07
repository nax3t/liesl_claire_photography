class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def new
    if current_user.admin
      @image = Image.new
    else
      redirect_to root_path
      flash.alert = "Access denied!"
    end
  end

  def create
    @image = current_user.images.build(image_params)
    if @image.save
      redirect_to @image
    else
      render :new
    end
  end

  def show
    @image = Image.find params[:id]
  end

  def edit
    if current_user.admin
      @image = Image.find params[:id]
    else
      redirect_to root_path
      flash.alert = "Access denied!"
    end
  end

  def update
    @image = Image.find params[:id]
    if @image.update image_params
      redirect_to @image
    else
      render :edit
    end
  end

  def destroy
    if current_user.admin
      @image = Image.find params[:id]
      @image.destroy
    else
      redirect_to root_path
      flash.notice = "Access denied!"
    end
  end

  private
    def image_params
      params.require(:image).permit(:caption, :image)
    end
end
