require 'product'

describe Product do
  subject(:product) { described_class.new(
    'test_name', 'test_code')
  }

  describe '#add_product_pack' do
    it 'raises an exception if the price is not a Float' do
      expect { product.add_product_pack(4, "StringPrice") }
        .to raise_exception(Product::InvalidPrice)

      expect { product.add_product_pack(4, 40) }
        .to raise_exception(Product::InvalidPrice)
    end

    it 'raises an exception for duplicate pack quantity' do
      product.add_product_pack(3, 50.00)

      expect { product.add_product_pack(3, 50.00) }
        .to raise_exception(Product::DuplicatePackQuantity)
    end

    it 'successfully create pack with right parameters and unique quantity' do
      product.add_product_pack(3, 50.00)

      expect(product.packs.count).to eq(1)
    end
  end

  describe '#min_quantity_purchase' do
    it 'returns nil if packs are empty' do
      expect(product.min_quantity_purchase).to eq(nil)
    end

    it 'returns min quantity of product packs' do
      product.add_product_pack(3, 50.00)
      product.add_product_pack(5, 50.00)

      expect(product.min_quantity_purchase).to eq(3)
    end
  end

  describe '#sort_packs_descending' do
    it 'returns nil if packs are empty' do
      expect(product.sort_packs_descending).to eq(nil)
    end

    it 'returns sorted packs in descending order' do
      product.add_product_pack(3, 30.25)
      product.add_product_pack(5, 50.50)
      product.add_product_pack(8, 80.25)

      expect(product.sort_packs_descending.keys.first).to eq(8)
      expect(product.sort_packs_descending.keys.last).to eq(3)
    end
  end
end