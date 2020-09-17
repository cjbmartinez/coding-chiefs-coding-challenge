class Order
  InvalidCart = Class.new(StandardError)

  attr_reader :items

  def initialize(cart)
    raise(InvalidCart, "Invalid Cart") unless cart.instance_of?(Cart)

    @cart = cart
    @items = []
  end

  def create_order_breakdown(products)
    product_codes = @cart.items.keys

    product_codes.each do |product_code|
      item = @cart.items[product_code]
      product = products[product_code]

      breakdown = ProductBreakdownBuilder.new(
        product, item[:quantity]
      ).create_product_breakdown

      @items << {
        total_quantity: item[:quantity],
        product_code: product_code,
        breakdown: breakdown,
        grand_total: breakdown.inject(0) { |sum, x| sum + x[:price] }.round(2)
      }
    end
  end

  def print_breakdown
    items.each do |item|
      puts "#{item[:total_quantity]} #{item[:product_code]} "\
           "$#{item[:grand_total]}"
      item[:breakdown].each do |breakdown|
        puts "\t#{breakdown[:quantity]} x #{breakdown[:pack_item_count]} "\
             "$#{breakdown[:price]}\n"
      end
    end
  end
end
