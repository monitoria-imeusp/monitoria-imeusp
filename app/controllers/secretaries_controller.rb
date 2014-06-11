class SecretariesController < ApplicationController
  before_action :set_secretary, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, :except => [:show, :index]

  # GET /secretaries
  # GET /secretaries.json
  def index
    @secretaries = Secretary.all
  end

  # GET /secretaries/1
  # GET /secretaries/1.json
  def show
  end

  # GET /secretaries/new
  def new
    @secretary = Secretary.new
  end

  # GET /secretaries/1/edit
  def edit
  end

  # POST /secretaries
  # POST /secretaries.json
  def create
    @secretary = Secretary.new(secretary_params)

    respond_to do |format|
      if @secretary.save
        format.html { redirect_to @secretary, notice: 'Funcionário(a) foi criado(a) com sucesso.' }
        format.json { render action: 'show', status: :created, location: @secretary }
      else
        format.html { render action: 'new' }
        format.json { render json: @secretary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secretaries/1
  # PATCH/PUT /secretaries/1.json
  def update
    if params[:secretary][:password].blank? && params[:secretary][:password_confirmation].blank?
      params[:secretary].delete(:password)
      params[:secretary].delete(:password_confirmation)
    end
    respond_to do |format|
      if @secretary.update(secretary_params)
        format.html { redirect_to @secretary, notice: 'Funcionário(a) foi atualizado(a) com sucesso.' }
        format.json { render action: 'show', status: :ok, location: @secretary }
      else
        format.html { render action: 'edit' }
        format.json { render json: @secretary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secretaries/1
  # DELETE /secretaries/1.json
  def destroy
    @secretary.destroy
    respond_to do |format|
      format.html { redirect_to secretaries_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_secretary
    @secretary = Secretary.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def secretary_params
    params.require(:secretary).permit(:nusp, :name, :email, :password, :password_confirmation)
  end
end
