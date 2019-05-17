class EUsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    EUser.create(name: params[:name], email: params[:email])
  end

  def index
    render json: EUser.find(params[:id])
  end
end
