class ApplicationController < ActionController::Base
  private

  def after_sign_in_path_for(_resource)
    boards_url
  end
end
