class ProfessorsController < ApplicationController
    def new
        @professor = Professor.new
    end

    def create
        @professor = Professor.new(professor_params)
        
        if @professor.save
            redirect_to @professor
        else
            render 'new'
        end
    end

    def show
        @professor = Professor.find(params[:id])
    end

    def index
        @professors = Professor.all
    end

    def edit
        @professor = Professor.find(params[:id])
    end

    def update
        @professor = Professor.find(params[:id])

        if @professor.update(params[:professor].permit(:name, :nusp, :department, :password, :email))
            redirect_to @professor
        else
            render 'edit'
        end
    end

    private
        def professor_params
            params.require(:professor).permit(:name, :nusp, :password, :department, :email)
        end
end
