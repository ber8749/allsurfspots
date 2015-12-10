require 'rails_helper'

describe SpotsController do

  describe 'GET #index' do
    it 'populates an array of spots' do
      spot = create(:spot)
      get :index
      expect(assigns(:spots).to_a).to eq([spot])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested spot to @spot' do
      spot = create(:spot)
      get :show, id: spot
      expect(assigns(:spot)).to eq(spot)
    end

    it 'renders the #show view' do
      get :show, id: create(:spot)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    context 'logged in' do
      login_user
      it 'renders the #new view' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'logged out' do
      it 'redirects to sign in' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST create' do
    login_user
    context 'with valid attributes' do
      before :each do
        spot = build(:spot)
        post :create, spot: spot.attributes
      end

      it 'creates a new spot' do
        expect(Spot.count).to eq(1)
      end

      it 'redirects to the new spot' do
        expect(response).to redirect_to Spot.last
      end
    end

    context 'with invalid attributes' do
      before :each do
        spot = build(:spot, :invalid)
        post :create, spot: spot.attributes
      end

      it 'does not save the new spot' do
        expect(Spot.count).to eq(0)
      end

      it 'renders the new method' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT update' do
    login_user
    before :each do
      @spot = create(:spot)
    end

    context 'valid attributes' do
      it 'located the requested @spot' do
        put :update, id: @spot, spot: FactoryGirl.attributes_for(:spot)
        expect(assigns(:spot)).to eq(@spot)
      end

      it "changes @spots's attributes" do
        put :update, id: @spot,
            spot: FactoryGirl.attributes_for(:spot, name: 'Test Spot', description: 'This spot is testy')
        @spot.reload
        expect(@spot.name).to eq('Test Spot')
        expect(@spot.description).to eq('This spot is testy')
      end

      it 'redirects to the updated spot' do
        put :update, id: @spot, spot: FactoryGirl.attributes_for(:spot)
        expect(response).to redirect_to @spot
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @spot' do
        put :update, id: @spot, spot: FactoryGirl.attributes_for(:spot,:invalid)
        expect(assigns(:spot)).to eq(@spot)
      end

      it "does not change @spot's attributes" do
        put :update, id: @spot,
            spot: FactoryGirl.attributes_for(:spot, :invalid)
        @spot.reload
        expect(@spot.name).not_to eq(nil)
      end

      it 're-renders the edit method' do
        put :update, id: @spot, spot: FactoryGirl.attributes_for(:spot,:invalid)
        expect(response).to render_template(:edit)
      end
    end
  end

end
