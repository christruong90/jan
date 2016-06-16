require 'rails_helper'

def product
  @product ||= FactoryGirl.create(:product)
end

RSpec.describe ProductsController, type: :controller do

  describe "#new" do
    it "renders a new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "instantiates a new product instance variable" do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end

  end

  describe "#create" do
    context "with valid attributes" do
      def valid_request
        post :create, product: FactoryGirl.attributes_for(:product)
      end

      it "saves a record to the database" do
          count_before = Product.count
          valid_request
          count_after  = Product.count
          expect(count_after).to eq(count_before + 1)
      end

      it "creates a new " do
      end
    end
  end

  describe "#edit" do
    it "renders the edit template" do
      get :edit, id: product.id
      expect(response).to render_template(:edit)
    end

    it "set an instance variable to the campaign with the id passed" do
      get :edit, id: product.id
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "#update" do
    context "with valid attributes" do
      def valid_request
        patch :update, id: product.id, product: {title: "new valid title"}
      end
      it "updates the record in the database" do
        valid_request
        expect(product.reload.title).to eq("new valid title")
      end
      it "redirects to the show page" do
        valid_request
        expect(response).to redirect_to(product_path(product))
      end
      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to eq("update successful")
      end
    end
    context "with invalid attributes" do
      def invalid_request
        patch :update, id: product.id, product: {title: ""}
      end
      it "doesnt save the new value to the database" do
        invalid_request
        expect(product.reload.title).to_not eq("")
      end
      it "renders the edit template" do
        invalid_request
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#destroy" do
    # using `let!` forces the block to be executed before every test example
    # regardless whether you call the method or not.
    let!(:product) { FactoryGirl.create(:product) }

    it "removes the record from the database" do
      count_before = Product.count
      delete :destroy, id: product.id
      count_after  = Product.count
      expect(count_before).to eq(count_after + 1)
    end

    it "redirects to products_path (listings page)" do
      delete :destroy, id: product.id
      expect(response).to redirect_to(products_path)
    end
  end

  describe "#show" do
    # the `before` defines a block that gets executed before every example
    before do
      get :show, id: product.id
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "sets an instance variable to the campaign with the passed id" do
      expect(assigns(:product)).to eq(product)
    end

  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "sets `products` instance variable to all products in the DB" do
      product_1 = FactoryGirl.create(:product)
      product_2 = FactoryGirl.create(:product)
      get :index
      expect(assigns(:products)).to match_array([product_1, product_2])
    end
  end
end
