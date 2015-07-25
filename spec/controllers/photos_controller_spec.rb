RSpec.describe PhotosController, type: :controller do
  describe 'GET #index' do
    before do
      @photos = Fabricate.times 20, :photo
      get :index
    end

    it 'returns 200 OK' do
      expect(response).to have_http_status :ok
    end

    it 'returns array of Photos' do
      expect(json.count).to eq @photos.count
    end
  end

  describe 'GET #show' do
    let(:photo) { Fabricate :photo }

    it 'returns 404 Not Found' do
      get :show, id: 99999

      expect(response).to have_http_status :not_found
    end

    it 'returns 200 OK' do
      get :show, id: photo.id

      expect(response).to have_http_status :ok
    end
  end

  describe 'POST #create' do
    let(:photo) { Fabricate.build :photo }

    it 'returns 201 Created' do
      post :create, photo: Fabricate.attributes_for(:photo)

      expect(response).to have_http_status :created
    end
  end

  describe 'PUT #update' do
    let(:photo) { Fabricate :photo }
    let(:new_photo) { Fabricate.build :photo }

    before do
      put :update, id: photo.id, photo: { title: new_photo.title }
    end

    it 'returns 200 OK' do
      expect(response).to have_http_status :ok
    end

    it 'returns the updated Photo object' do
      expect(json['title']).to eq(new_photo.title)
    end
  end

  describe 'DELETE #destroy' do
    let(:photo) { Fabricate :photo }

    before do
      delete :destroy, id: photo.id
    end

    it 'returns 200 OK' do
      expect(response).to have_http_status :ok
    end

    it 'delete Dive Site from DB' do
      expect(Photo.all).not_to include photo
    end
  end
end
