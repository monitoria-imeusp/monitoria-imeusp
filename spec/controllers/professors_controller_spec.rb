require 'spec_helper'

describe ProfessorsController do

  before do
    @professor = mock_model(Professor)
    @id = "42"
  end

  context 'when logged in as admin' do
    login_admin

    describe 'new' do
      before :each do
        Professor.should_receive(:new).and_return(nil)
        get :new
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end

    describe 'create' do
      before do
        @params = { professor: { name: 'teste' } }
        Professor.should_receive(:new).with(any_args).and_return(@professor)
      end

      context 'fails to save' do
        before :each do
          @professor.should_receive(:save).and_return(false)
          post :create, @params
        end
        it { should render_template :new }
      end

      context 'succeeds to save' do
        before :each do
          @professor.should_receive(:save).and_return(true)
          post :create, @params
        end
        it { should redirect_to @professor }
      end
    end

    describe 'show' do
      context 'professor exists' do
        before :each do
          Professor.should_receive(:exists?).with(@id).and_return(true)
          Professor.should_receive(:find).with(@id).and_return(@professor)
          get :show, id: @id
        end
        it { should render_template :show }
      end

      context 'professor does not exist' do
        before :each  do
          Professor.should_receive(:exists?).with(@id).and_return(false)
          get :show, id: @id
        end
        it { should redirect_to professors_path }
      end
    end

    describe 'index' do
      before :each do
        Professor.should_receive(:all)
        get :index
      end
      it { should render_template :index }
    end

    describe 'edit' do
      context 'professor does exist' do
        before :each do
          Professor.should_receive(:exists?).with(@id).and_return(true)
          Professor.should_receive(:find).with(@id).and_return(true)
          get :edit, id: @id
        end
        it { should render_template :edit }
      end

      context "professor does not exist"  do
        before :each do
          Professor.should_receive(:exists?).with(@id).and_return(false)
          get :edit, id: @id
        end
        it { should redirect_to professors_path }
      end
    end

    describe 'update' do
      context 'a professor that does not exist' do
        before :each do
          Professor.should_receive(:exists?).with(@id).and_return(false)
          put :update, id: @id, professor: { id: @id }
        end
        it { should redirect_to professors_path }
      end

      context 'a professor that does exist' do
        before do
          Professor.should_receive(:exists?).with(@id).and_return(true)
          Professor.should_receive(:find).with(@id).and_return(@professor)
        end

        context 'but fails to update' do
          before :each do
            @professor.should_receive(:update).with(any_args).and_return(false)
            put :update, id: @id, professor: { id: @id }
          end
          it { should render_template :edit }
        end

        context 'and succeeds to update' do
          before :each do
            @professor.should_receive(:update).with(any_args).and_return(true)
            put :update, id: @id, professor: { id: @id }
          end
          it { should redirect_to @professor }
        end
      end

    end
  end

  context 'when logged in as professor' do
    login_professor

    describe 'index' do
      before :each do
        Professor.should_receive(:all)
        get :index
      end
      it { should render_template :index }
    end

    describe 'show' do
      context 'professor exists' do
        before :each do
          Professor.should_receive(:exists?).with(@id).and_return(true)
          Professor.should_receive(:find).with(@id).and_return(@professor)
          get :show, id: @id
        end
        it { should render_template :show }
      end

      context 'professor does not exist' do
        before :each  do
          Professor.should_receive(:exists?).with(@id).and_return(false)
          get :show, id: @id
        end
        it { should redirect_to professors_path }
      end
    end

  end
end
