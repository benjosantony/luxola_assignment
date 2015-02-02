require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do
  let(:valid_attributes) { {name: 'Apple', description: 'This is apple', price: 40}}
  let(:valid_attributes2) { {name: 'Orange', description: 'This is Orange', price: 50}}
  let(:invalid_attributes) {{name:'',description: 'This is apple', price: 40}}
  # No session stuff required as we are not building authentication for this  app, otherwise required
  let(:valid_session) { {} }


  # Check the index
  describe "GET index" do
    it "should assign all products as @products" do
      product = Product.create! valid_attributes
      get :index, {}, valid_session
      # Expect @products to contain the newly created product
      expect(assigns(:products)).to eq([product])
    end
  end


  # Check the ajax get methods
  describe "GET show ajax" do
    it 'should assign the correct product as @product' do
      product  = Product.create! valid_attributes
      xhr :get , :show ,{id:product.id},valid_session
      expect(assigns(:product)).to eq(product)
    end

  end
  describe 'GET new ajax ' do
    it  'should assign a new product as @product' do
      xhr :get , :new , {},valid_session
      expect(assigns (:product)).to be_new_record
    end
  end

  describe 'GET edit ajax ' do
    it "should assign the correct product as @product " do
      product  = Product.create! valid_attributes
      xhr :get ,:edit ,{id:product.id}, valid_session
      expect(assigns(:product)).to eq(product)
    end
  end


  describe 'POST create ajax ' do
    it "should save the items to the database if params are valid" do
      count = Product.count
      xhr :post, :create ,  product: valid_attributes
      expect(Product.count).to eq(count+1)
    end

    it "should not save the items to the database if the params are in valid"  do
      count = Product.count
      xhr :post, :create ,  product: invalid_attributes
      expect(Product.count).not_to eq(count +1)
    end
  end

  describe 'PUT update ajax' do
    it "should update the item if attributes are valid" do
        product  = Product.create! valid_attributes;
        xhr :put, :update ,  {product: valid_attributes2,id: product.id}
        product =Product.find(product.id)
        # We find the product and check if the columns have changed (it should have changed)
        expect(product.name).to be == valid_attributes2[:name]
        expect(product.description).to be == valid_attributes2[:description]
        expect(product.price).to be == valid_attributes2[:price]
    end
    it "should not update the item if attributes are invalid" do
        product  = Product.create! valid_attributes;
        xhr :put, :update ,  {product: invalid_attributes,id: product.id}
        # We find the product and check if the columns have changed (it should not have changed)
        product =Product.find(product.id)
        expect(product.name).to be == valid_attributes[:name]
        expect(product.description).to be == valid_attributes[:description]
        expect(product.price).to be == valid_attributes[:price]
    end
  end

  describe 'DELETE DESTROY ajax' do
      it "should delete the record from the database" do
        product = Product.create! valid_attributes;
        xhr :delete, :destroy ,  {id: product.id}
        expect {Product.find(product.id)}.to raise_error ActiveRecord::RecordNotFound
      end
  end



end
