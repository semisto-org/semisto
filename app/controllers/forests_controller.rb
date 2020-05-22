class ForestsController < ApplicationController
  before_action :set_forest, only: [:show, :edit, :update, :destroy]

  # GET /forests
  # GET /forests.json
  def index
    @forests = Forest.all
  end

  # GET /forests/1
  # GET /forests/1.json
  def show
  end

  # GET /forests/new
  def new
    @forest = Forest.new
  end

  # GET /forests/1/edit
  def edit
  end

  # POST /forests
  # POST /forests.json
  def create
    @forest = Forest.new(forest_params)

    respond_to do |format|
      if @forest.save
        format.html { redirect_to @forest, notice: 'Forest was successfully created.' }
        format.json { render :show, status: :created, location: @forest }
      else
        format.html { render :new }
        format.json { render json: @forest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forests/1
  # PATCH/PUT /forests/1.json
  def update
    respond_to do |format|
      if @forest.update(forest_params)
        format.html { redirect_to @forest, notice: 'Forest was successfully updated.' }
        format.json { render :show, status: :ok, location: @forest }
      else
        format.html { render :edit }
        format.json { render json: @forest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forests/1
  # DELETE /forests/1.json
  def destroy
    @forest.destroy
    respond_to do |format|
      format.html { redirect_to forests_url, notice: 'Forest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forest
      @forest = Forest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def forest_params
      params.require(:forest).permit(:name)
    end
end
