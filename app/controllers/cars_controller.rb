# frozen_string_literal: true

class CarsController < ApplicationController
  before_action :set_car, only: %i[show edit update destroy like]
  before_action :set_makes, except: %i[show destroy]
  before_action :is_admin!, except: [:index, :show, :edit, :update, :like]
  before_action :authenticate_user!, only: [:like]


  def index
    set_cars_and_make_with_criteria(params[:make], params[:order], '')
  end

  def search
    set_cars_and_make_with_criteria(params[:make], params[:order] , params[:state])
  end


  def show; end

  def new
    @car = Car.new
  end

  def edit; end

  def create
    @car = Car.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to cars_path, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    if current_user.voted_for? @car
      @car.unlike_by current_user
    else
      @car.liked_by current_user
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_car
    @car = Car.find(params[:id])
  end

  def set_makes
    @makes = Make.all
  end

  def set_states
    @states = State.all
  end

  # Only allow a list of trusted parameters through.
  def car_params
    params.require(:car).permit(:title, :description, :feature, :price, :model, :thumbnail, :year, :color, :miles, make_ids: [], state_ids: [])
  end

  def set_cars_and_make_with_criteria(requested_make, requested_order, requested_state)
    if requested_make.nil? || requested_make.eql?('All')
      cars_by_make = Car.all
      @make_name = 'All'
    else
      cars_by_make = filter_cars_by_make(requested_make)
      @make_name = requested_make
    end

    if requested_state == '' || requested_state.nil? || requested_state.eql?('All')
      cars_by_state = cars_by_make
    else
      cars_by_state = filter_cars_by_state(requested_state, cars_by_make)
    end
    @order = requested_order
    order_cars(requested_order, cars_by_state)
  end

  def filter_cars_by_make(make_name)
    @make = Make.find_by(name: make_name)
    cars = if @make.nil?
             Car.none
           else
             @make.cars
           end
  end

  def filter_cars_by_state(state_name, cars_by_make)
    @make = State.find_by(state: state_name)
    cars = if @make.nil?
             # Car.none
           else
             @make.cars.where(id: cars_by_make.pluck(:id))

           end

  end

  def order_cars(_order, _cars)
    @cars = case _order
              when 'A-Z'
                _cars.order('title ASC')
              when 'Z-A'
                _cars.order('title DESC')
              when 'Highest Priced First'
                _cars.order('price DESC')
              when 'Lowest Priced First'
                _cars.order('price ASC')
              when 'Newest First'
                _cars.order('created_at DESC')
              when 'Oldest First'
                _cars.order('created_at ASC')
              else
                _cars.order('title ASC')
            end
  end
end