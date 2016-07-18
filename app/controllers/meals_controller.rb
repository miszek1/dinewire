class MealsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_meal, only: [:edit, :update, :destroy]

  # GET /meals
  # GET /meals.json
  def index
    @meals = current_user.meals.all
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
    @meal = Meal.find(params[:id])
  end

  # GET /meals/new
  def new
    @meal = current_user.meals.build
  end

  # GET /meals/1/edit
  def edit
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = current_user.meals.build(meal_params)
    @meal.ip_address = request.location.ip
    @meal.expires_at = DateTime.now + 1.hour

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    if params[:meal][:expires_at] == "1"
      params[:meal][:expires_at] = 1.hour.from_now
    else 
      params[:meal].delete(:expires_at)
    end

    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url, notice: 'Meal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @search = Meal.search(params[:q]).near([35.43, -118.83], 20, :order => "distance")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = current_user.meals.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:name, :description, :location, :image, :expires_at)
    end

end
