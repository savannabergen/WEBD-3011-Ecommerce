class CheckoutsController < ApplicationController
  def create
    stripe_secret_key = Rails.application.credentials.dig(:production, :stripe_api_secret)
    Stripe.api_key = stripe_secret_key
    cart = params[:cart]
    line_items = cart.map do |item|
      if item["size"].blank?
        render json: { error: "Please select a size for #{item["name"]}" }, status: 400
        return
      end

      product = Product.find(item["id"])
      product_stock = product.stocks.find { |ps| ps.size == item["size"] }

      {
        quantity: item["quantity"].to_i,
        price_data: {
          product_data: {
            name: item["name"],
            metadata: { product_id: product.id, size: item["size"], product_stock_id: product_stock.id }
          },
          currency: "cad",
          unit_amount: item["price"].to_i
        }
      }
    end

    puts "line_items: #{line_items}"

    session = Stripe::Checkout::Session.create(
      mode: "payment",
      line_items: line_items,
      success_url: "http://localhost:3000/success",
      cancel_url: "http://localhost:3000/cancel",
      shipping_address_collection: {
        allowed_countries: [ "US", "CA" ]
      }
    )

    render json: { url: session.url }
  end

  def success
    render :success
  end

  def cancel
    render :cancel
  end

  private

  def validate_cart_items
    cart = params[:cart]
    cart.each do |item|
      if item["size"].blank?
        render json: { error: "Please select a size for #{item["name"]}" }, status: 400
      end
    end
  end
end
