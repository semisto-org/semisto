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

    respond_to do |format|
      if @plant.save
        format.html { redirect_to forest_plants_path(@forest.id), notice: _('Plant was successfully added.') }
        format.json { render :show, status: :created, location: @plant }
      else
        format.html { render :new }
        format.json { render json: @plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plants/1
  # PATCH/PUT /plants/1.json
  def update
    respond_to do |format|
      if @plant.update(plant_params)
        format.html { redirect_to @plant, notice: _('Plant was successfully updated.') }
        format.json { render :show, status: :ok, location: @plant }
      else
        format.html { render :edit }
        format.json { render json: @plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plants/1
  # DELETE /plants/1.json
  def destroy
    @plant.destroy
    respond_to do |format|
      format.html { redirect_to plants_url, notice: 'Plant was successfully destroyed.' }
      format.json { head :no_content }
    end
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
