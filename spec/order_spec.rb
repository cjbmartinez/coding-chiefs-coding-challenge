require 'cart'
require 'product'
require 'bakery'
require 'order'
require 'product_breakdown_builder'

describe Order do
  bakery = Bakery.new

  product = Product.new("test_name", "test_code")
  product.add_product_pack(3, 10.25)

  bakery.add_product(product)

  cart = Cart.new
  cart.add_cart_item(bakery.products, "test_code", 3)

  describe '#initialize' do
    it 'raises an exception if cart parameter in not a Cart Instance' do
      expect { described_class.new("testCart") }
        .to raise_exception(
          Order::InvalidCart, "Invalid Cart"
        )
    end
  end

  describe '#create_order_breakdown' do
    it 'raises an exception if no pack combination for cart item quantity' do
      cart.add_cart_item(bakery.products, "test_code", 4)
      # Added Cart Item has only a pack containing 3

      order = described_class.new(cart)
      expect { order.create_order_breakdown(bakery.products) }
        .to raise_exception(
          ProductBreakdownBuilder::InvalidQuantity,
          "No Product Packs Available for 4 test_code"
        )
    end

    it 'successfully create pack right cart item params' do
      cart.add_cart_item(bakery.products, "test_code", 3)
      # Added Cart Item has only a pack containing 3
      order = described_class.new(cart)
      order.create_order_breakdown(bakery.products)

      expect(order.items.count).to eq(1)
    end
  end
end