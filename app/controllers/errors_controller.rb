class ErrorsController < ApplicationController
  layout "frontend"
  
  def error404
    @content_type = '404'
    render status: :not_found
  end
end