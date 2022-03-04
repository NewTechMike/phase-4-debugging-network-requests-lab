class ToysController < ApplicationController
  wrap_parameters format: []

  def index
    toys = Toy.all
    render json: toys
  end

  def create
    toy = Toy.create!(toy_params)
    render json: toy, status: :created
  rescue ActiveRecord::RecordInvalid => e 
    render_invalid(e)
  end

  def update
    #byebug
    toy = Toy.find_by(id: params[:id])
    toy.update(likes: params[:likes] )
    render json: toy
  rescue ActiveRecord::RecordInvalid => e
    render_invalid(e)
  end

  def destroy
    toy = Toy.find_by(id: params[:id])
    toy.destroy
    head :no_content
  rescue ActiveRecord::RecordInvalid => e
    render_invalid(e)
  end

  private
  
  def toy_params
    params.permit(:name, :image, :likes)
  end

  def render_invalid(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

end
