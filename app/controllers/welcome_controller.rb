class WelcomeController < ApplicationController
  before_action :set_user
  def feed

  end

  private
  def set_user
  	@user = User.find_by_id(params[:id])
  	if (@user.nil?)
  	  head :not_found
  	end
  end
end
