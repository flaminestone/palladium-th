require 'json'
class AbstractProductPack
  attr_accessor :products

  def initialize(product_pack)
    @products = []
    products = JSON.parse(product_pack.body)['products']
    products.map do |product|
      @products << AbstractProduct.new('product' => product)
    end
  end

  def diff(product_pack)
    self_ids = @products.map(&:id)
    other_ids = product_pack.products.map(&:id)
    self_ids - other_ids | other_ids - other_ids
  end

  def get_product_by_id(id)
    @products.detect { |product| product.id == id}
  end
end