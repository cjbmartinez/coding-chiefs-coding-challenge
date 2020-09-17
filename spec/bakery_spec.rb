require 'product'
require 'bakery'

describe Bakery do
  subject(:bakery) { described_class.new }

  product_one = Product.new("test_name", "test_code")

  describe '#add_product' do
    it 'raises an exception if the product passed is not a Product instance' do
      expect { bakery.add_product("TestProduct") }
        .to raise_exception(Bakery::InvalidProduct)
    end

    it 'raises an exception for duplicate product' do
      bakery.add_product(product_one)

      expect { bakery.add_product(product_one) }
        .to raise_exception(Bakery::DuplicateProduct)
    end

    it 'successful adding of product if passed with unique product instance' do
      bakery.add_product(product_one)

      expect(bakery.products.count).to eq(1)
    end
  end
end