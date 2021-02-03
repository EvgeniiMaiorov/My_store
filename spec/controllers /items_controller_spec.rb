require 'rails_helper'

describe ItemsController, :type => :controller do
    
    it_renders_404_page_when_item_is_not_found :show, :edit, :update, :destroy

    describe "show action" do
        
        it 'renders show template if an item is found' do
            
            item = create(:item)
            get :show, id: item.id
            expect(response).to render_template("show")

        end

    end

    describe "create action" do
        
        it 'redirect to item page if validations pass' do
            
            post :create, item: {name: 'Item 1', price: '10', description: 'description'}, admin: 1
            expect(response).to redirect_to(item_path(assigns(:item)))

        end

        it 'renders new page if validations fail' do

            post :create, item: { name: 'dsgsdgtem', price: 100, description: nil }, admin: 1
            expect(response).to render_template("new")

        end

        it 'render 403 page if user is not an admin' do
            
            post :create, item: {name: 'Item', price: '10', description: 'description'}
            expect(response.status).to eq(403) 

        end

    end

    describe "destroy action" do

        it 'redirects to index action when an item is destroyed successfully' do

            item = create(:item)
            delete :destroy, id: item.id, admin: 1
            expect(response).to redirect_to(items_path)
        
        end

    end

end