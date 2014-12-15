class AdvisesController < ApplicationController
  before_action :set_advise, only: [:show, :edit, :update, :destroy]

  # GET /advises/new
  def new
    @advise = Advise.new
  end

  # GET /advises/1/edit
  def edit
  end

  # POST /advises/1/moveup
  def moveup
    id = params[:id]
    last = nil
    Advise.all.order(:order).each do |advise|
      if advise.id == id.to_i and not last.nil?
        advise.order, last.order = last.order, advise.order
        advise.save
        last.save
      end
      last = advise
    end
    redirect_to root_path
  end

  # POST /advises/1/movedown
  def movedown
    id = params[:id]
    last = nil
    Advise.all.order(:order).each do |advise|
      if not last.nil? and last.id == id.to_i
        advise.order, last.order = last.order, advise.order
        advise.save
        last.save
      end
      last = advise
    end
    redirect_to root_path
  end

  # POST /advises
  # POST /advises.json
  def create
    @advise = Advise.new(advise_params)
    @advise.order = Advise.order(:order).last.order+1
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
