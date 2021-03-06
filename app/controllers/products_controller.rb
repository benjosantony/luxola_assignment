class ProductsController < ApplicationController
  # Set the @product before running the actions
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
    @products  = Product.order 'id desc'
  end

  # GET /products/1
  def  show
  end

  # GET /products/new
  def new
    @product  = Product.new
  end

  # POST /products
  def create
    @product = Product.new(product_params)
    if @product.save
      render :show
    else
      render :new
    end
  end

  # GET /products/1/edit
  def edit
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render :show
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    @products  = Product.order 'id desc'
    render :index
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

end
