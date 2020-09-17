class Seed
  ProductData = [
    {
      name: "Vegemite Scroll",
      code: "VS5",
      packs: [
        { quantity: 3, price: 6.99 },
        { quantity: 5, price: 8.99 }
      ]
    },
    {
      name: "Blueberry Muffin",
      code: "MB11",
      packs: [
        { quantity: 2, price: 9.95 },
        { quantity: 5, price: 9.95 },
        { quantity: 8, price: 9.95 },
      ]
    },
    {
      name: "Croissant",
      code: "CF",
      packs: [
        { quantity: 3, price: 5.95 },
        { quantity: 5, price: 9.95 },
        { quantity: 9, price: 16.99 }
      ]
    }
  ]

  def self.create_bakery
    bakery = Bakery.new
    ProductData.each do |product|
      new_product = Product.new(product[:name], product[:code])
      product[:packs].each do |pack|
        new_product.add_product_pack(pack[:quantity], pack[:price])
      end
      bakery.add_product(new_product)
    end
    bakery
  end
end
