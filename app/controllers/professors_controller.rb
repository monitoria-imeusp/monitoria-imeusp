class ProfessorsController < ApplicationController
    def new
    end

    def create
        @professor = Professor.new(professor_params)
        @professor.save
        redirect_to @professor
    end

    def show
        @professor = Professor.find(params[:id])
    end

    def index
        @professors = Professor.all
    end

    private
        def professor_params
            params.require(:professor).permit(:name, :nusp, :password, :department, :email)
        end
end
