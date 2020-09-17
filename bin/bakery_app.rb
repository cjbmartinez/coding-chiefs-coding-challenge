require 'optparse'
require_relative '../lib/product'
require_relative '../lib/bakery'
require_relative '../lib/cart'
require_relative '../lib/order'
require_relative '../lib/seed'
require_relative '../lib/product_breakdown_builder'

def collect_cart_items(products)
  cart = Cart.new
  cart_purchase_count = 1
  while (cart.items.length < 3) do
    print "\nEnter Product Purchase ##{cart_purchase_count}: "
    quantity, code = gets.split(" ")
    begin
      cart.add_cart_item(products, code, quantity)
    rescue StandardError => e
      puts e.message
      next
    end
    cart_purchase_count += 1
  end
  cart
end

def restart_purchase(bakery)
  print "\nDo you want to try again? [Y/N]: "
  return start_purchase_process(bakery) if gets.include?("Y")
  exit
end

def start_purchase_process(bakery)
  cart = collect_cart_items(bakery.products)

  order = Order.new(cart)
  begin
    order.create_order_breakdown(
      bakery.products
    )
  rescue StandardError => e
    puts e.message
    restart_purchase
  end
  order.print_breakdown

  restart_purchase(bakery)
end

bakery = Seed.create_bakery
start_purchase_process(bakery)


