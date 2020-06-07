class ForestsController < ApplicationController
  before_action :set_forest, only: [:show, :edit, :update, :destroy]

  def index
    @forests = Forest.all
  end

  def show
  end

  def new
    @forest = Forest.new
  end

  def edit
  end

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

  def update
    respond_to do |format|
      if @forest.update(forest_params)
        format.html {
          puts "HTML"
          redirect_to @forest, notice: 'Forest was successfully updated.'
        }
        format.json {
          puts "JSON"
          render :show, status: :ok, location: @forest
        }
      else
        format.html { render :edit }
        format.json { render json: @forest.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @forest.destroy
    respond_to do |format|
      format.html { redirect_to forests_url, notice: 'Forest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_forest
    @forest = Forest.find(params[:id])
  end

  def forest_params
    params
      .require(:forest)
      .permit!
      # .permit(
      #   :drawn_items,
      #   :name
      # )
  end
end
