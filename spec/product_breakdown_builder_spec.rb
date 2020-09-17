require 'cart'
require 'product'
require 'bakery'
require 'order'
require 'product_breakdown_builder'

describe ProductBreakdownBuilder do
  bakery = Bakery.new

  product = Product.new("test_name", "test_code")
  product.add_product_pack(3, 10.25)

  bakery.add_product(product)

  cart = Cart.new
  cart.add_cart_item(bakery.products, "test_code", 3)

  subject(:builder) { described_class.new(product, 3) }

  describe '#initialize' do
    it 'raises an exception if product parameter in not a Product Instance' do
      expect {
        described_class.new("testProduct", 3)
      }.to raise_exception(
        ProductBreakdownBuilder::InvalidProduct, "Invalid Product"
      )
    end

    it 'raises an exception if product parameter in not a Product Instance' do
      expect {
        described_class.new(product, "test")
      }.to raise_exception(
        ProductBreakdownBuilder::InvalidQuantity, "Invalid Quantity: test"
      )
    end
  end

  describe '#create_product_breakdown' do
    it 'raises an exception if no pack combination for cart item quantity' do

      expect { described_class.new(product, 4).create_product_breakdown }
        .to raise_exception(
          ProductBreakdownBuilder::InvalidQuantity,
          "No Product Packs Available for 4 test_code"
        )
    end

    it 'successfully create pack right cart item params' do
      expect(described_class.new(product, 6).create_product_breakdown).to eq([{
        pack_item_count: 3,
        quantity: 2,
        price: 10.25 * 2
      }])
    end
  end
end