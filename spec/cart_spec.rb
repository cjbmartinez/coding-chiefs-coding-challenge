require 'cart'
require 'product'
require 'bakery'

describe Cart do
  subject(:cart) { described_class.new }
  bakery = Bakery.new
  product = Product.new("test_name", "test_code")
  product.add_product_pack(3, 10.25)
  bakery.add_product(product)

  describe '#add_cart_item' do
    it 'raises an exception if the code is not existing in any Product' do
      expect { cart.add_cart_item(bakery.products, "nonExistingCode", 5) }
        .to raise_exception(
          Cart::InvalidProductCode, "Invalid Code nonExistingCode"
        )
    end

    it 'raises an exception if quantity is not an integer' do
      expect { cart.add_cart_item(bakery.products, "test_code", "test") }
        .to raise_exception(StandardError, 'Invalid Quantity: test')
    end

    it 'raises an exception if quantity is below min required quantity' do
      expect { cart.add_cart_item(bakery.products, "test_code", 1) }
        .to raise_exception(
          Cart::InvalidQuantity, "Min Quantity for test_code is 3"
        )
    end

    it 'successfully create pack with right code and quantity' do
      cart.add_cart_item(bakery.products, "test_code", 3)

      expect(cart.items.count).to eq(1)
    end
  end
end