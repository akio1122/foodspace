class ThumbController < ApplicationController
  def thumb
    @image = Image.find(params[:id])
    redirect_to @image.dynamic_file_url("#{params['width']}x#{params['height']}>")
    #puts 'asd'
  end
end
