class PlantsController < ApplicationController
  before_action :set_forest
  before_action :set_plant, only: [:show, :edit, :update, :destroy]

  def index

  end

  # GET /plants/1
  # GET /plants/1.json
  def show
  end

  # GET /plants/new
  def new
    @forest = Forest.find(params[:forest_id])
    @plant = @forest.plants.new
  end

  # GET /plants/1/edit
  def edit
  end

  # POST /plants
  # POST /plants.json
  def create
    @forest = Forest.find(params[:forest_id])
    @plant = @forest.plants.new(plant_params)

    if @plant.save
      redirect_to forest_plants_path(@forest.id), notice: _('Plant was successfully added.')
    else
      render :new
    end
  end

  # PATCH/PUT /plants/1
  # PATCH/PUT /plants/1.json
  def update
    if @plant.update(plant_params)
      redirect_to forest_plant_path(@forest, @plant), notice: _('Plant was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE /plants/1
  # DELETE /plants/1.json
  def destroy
    @plant.destroy
    redirect_to forest_plants_url(@forest), notice: 'Plant was successfully removed.'
  end

  private

  def set_forest
    @forest = Forest.find(params[:forest_id])
  end

  def set_plant
    @plant = Plant.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def plant_params
    params.require(:plant).permit(:name, :common_name)
  end
end
