class ReviewsController < ApplicationController
  def create
    @review = Review.new review_params
    @product = Product.find params[:product_id]
    @review.product = @product
    if @review.save
      redirect_to product_path(@product)
    else
      render "products/show"
    end
  end

  def destroy
    product = Product.find params[:product_id]
    review = Review.find params[:id]
    review.destroy
    redirect_to product_path(product)
  end

  private

    def review_params
      params.require(:review).permit(:star_count, :body)
    end

end
