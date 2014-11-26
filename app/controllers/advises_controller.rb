class AdvisesController < ApplicationController
  before_action :set_advise, only: [:show, :edit, :update, :destroy]

  # GET /advises
  # GET /advises.json

  # GET /advises/1
  # GET /advises/1.json
  def show
  end

  # GET /advises/new
  def new
    @advise = Advise.new
  end

  # GET /advises/1/edit
  def edit
  end

  # POST /advises
  # POST /advises.json
  def create
    @advise = Advise.new(advise_params)

    respond_to do |format|
      if @advise.save
        format.html { redirect_to root_path, notice: 'Aviso criado com sucesso.' }
        format.json { render action: 'show', status: :created, location: @advise }
      else
        format.html { render action: 'new' }
        format.json { render json: @advise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advises/1
  # PATCH/PUT /advises/1.json
  def update
    respond_to do |format|
      if @advise.update(advise_params)
        format.html { redirect_to root_path, notice: 'Aviso editado com sucesso.' }
        format.json { render action: 'show', status: :ok, location: @advise }
      else
        format.html { render action: 'edit' }
        format.json { render json: @advise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advises/1
  # DELETE /advises/1.json
  def destroy
    @advise.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advise
      @advise = Advise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advise_params
      params.require(:advise).permit(:title, :message, :advise_urgency)
    end
end
