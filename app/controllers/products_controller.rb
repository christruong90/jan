class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    product_params = params.require(:product).permit(:title, :description, :price, :sale_price, :category_id)
    @product = Product.new product_params
    if @product.save
      redirect_to product_path(@product), notice: "product created"
    else
      flash[:alert] = "product failed to generate"
      render :new
    end
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    product_params = params.require(:product).permit(:title, :body, :goal, :end_date)
    @product = Product.find params[:id]
    if @product.update product_params
      # flash[:notice] = "update successful"
      redirect_to product_path(@product), notice: "update successful"
    else
      render :edit
    end
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new
  end

  def index
    @products = Product.order(:created_at)
  end

  def destroy
    product = Product.find params[:id]
    product.destroy
    redirect_to products_path
  end

end
