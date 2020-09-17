class Bakery
  InvalidProduct = Class.new(StandardError)
  DuplicateProduct = Class.new(StandardError)

  attr_reader :products

  def initialize
    @products = {}
  end

  def add_product(product)
    raise(InvalidProduct, "Invalid Product") unless
      product.instance_of?(Product)
    raise(DuplicateProduct, "Dupicate Product Code: #{product.code}") if
      products.key?(product.code)

    products[product.code] = product
  end
end
