class Product
  InvalidPrice = Class.new(StandardError)
  DuplicatePackQuantity = Class.new(StandardError)

  attr_reader :name, :code, :packs

  def initialize(name, code)
    @name = name
    @code = code
    @packs = {}
  end

  def add_product_pack(quantity, price)
    raise(InvalidPrice, "Invalid price #{price}") unless
      price.instance_of?(Float)
    raise(
      DuplicatePackQuantity,
      "Product Pack with quantity of: #{quantity} already exists"
    ) if packs.key?(quantity)

    packs[quantity] = price
  end

  def min_quantity_purchase
    return if packs.empty?

    packs.min_by { |k, _v| k }.first
  end

  def sort_packs_descending
    return if packs.empty?

    packs.sort_by { |_k, v| v }.reverse.to_h
  end
end
