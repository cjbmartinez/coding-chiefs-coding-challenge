class Cart
  InvalidProductCode = Class.new(StandardError)
  InvalidQuantity = Class.new(StandardError)

  attr_reader :items

  def initialize
    @items = {}
  end

  def add_cart_item(products, code, quantity)
    raise(InvalidProductCode, "Invalid Code #{code}") if products[code].nil?

    begin
      item_quantity = Integer(quantity)
    rescue StandardError
      raise StandardError, "Invalid Quantity: #{quantity}"
    end

    min_quantity = products[code].min_quantity_purchase
    min_qty_err_msg = "Min Quantity for #{code} is #{min_quantity}"
    raise(InvalidQuantity, min_qty_err_msg) if item_quantity < min_quantity

    items[code] = {
      quantity: Integer(quantity),
      breakdown: []
    }
  end
end
