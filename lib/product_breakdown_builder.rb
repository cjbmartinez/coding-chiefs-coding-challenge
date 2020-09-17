class ProductBreakdownBuilder
  InvalidQuantity = Class.new(StandardError)
  InvalidProduct = Class.new(StandardError)

  def initialize(product, quantity)
    raise(InvalidProduct, "Invalid Product") unless
      product.instance_of?(Product)

    @breakdown = []
    @product = product
    @product_packs = product.sort_packs_descending
    begin
      @cart_item_quantity = Integer(quantity)
    rescue
      raise InvalidQuantity, "Invalid Quantity: #{quantity}"
    end
  end

  def create_product_breakdown
    orig_quantity = @cart_item_quantity
    while (@cart_item_quantity != 0) do
      @breakdown = [] unless @breakdown.empty?

      create_product_pack_combination
      if @cart_item_quantity > 0
        @cart_item_quantity = orig_quantity
        @product_packs.shift
        raise(
          InvalidQuantity,
          "No Product Packs Available for #{orig_quantity} #{@product.code}"
        ) if @product_packs.empty?
      end
    end
    @breakdown.reject { |k, _v| k[:price].zero? }
  end

  private

  def create_product_pack_combination
    @product_packs.each_with_index do |pack, index|
      pack_quantity, pack_price = pack

      no_of_packs = @cart_item_quantity / pack_quantity
      remainder = @cart_item_quantity % pack_quantity
      next if index > 0 && remainder > 0

      @cart_item_quantity = remainder

      @breakdown << {
        pack_item_count: pack_quantity,
        quantity: no_of_packs,
        price: (pack_price * no_of_packs).round(2)
      }

    end
  end
end
