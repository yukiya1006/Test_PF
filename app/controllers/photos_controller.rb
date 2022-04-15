class PhotosController < ApplicationController

  def index
    @photo = Photo.new
    @photos = Photo.all
    @user = current_user
    @trainer = current_trainer
  end

  def new
    @photo = Photo.new
    @trainer = current_trainer
  end

  def create
    @trainer = current_trainer
    @photo = Photo.new(photo_params)
    @photo.trainer_id = current_trainer.id
    if @photo.save
      redirect_to photos_path
    else
      render :new
    end
  end

  def edit
    @trainer = current_trainer
    @photo = Photo.find(params[:id])
  end

  def update
     @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      redirect_to photos_path, notice: "プロフィールが更新されました"
    else
      redirect_to edit_photo_path
    end
  end

  def destroy
    photo = Photo.find(params[:id])
    photo.destroy
    redirect_to photos_path
  end


  private

  def photo_params
    params.require(:photo).permit(:image, :caption, :trainer_id)
  end
end
