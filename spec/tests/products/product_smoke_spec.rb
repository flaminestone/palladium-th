require_relative '../../tests/test_management'
http = nil
describe 'Product Smoke' do
  before :all do
    http = Net::HTTP.new(StaticData::ADDRESS, StaticData::PORT)
  end
  describe 'Create new product' do
    it 'check creating new product with correct user_data and correct product_data' do
      request = Net::HTTP::Post.new('/api/product_new','Authorization' => StaticData::TOKEN)
      corrent_product_name = 30.times.map { StaticData::ALPHABET.sample }.join
      request.set_form_data({"product_data[name]": corrent_product_name})
      response = http.request(request)
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['errors'].empty?).to be_truthy
      expect(JSON.parse(response.body)['product']['id'].nil?).to be_falsey
      expect(JSON.parse(response.body)['product']['name']).to eq(corrent_product_name)
    end

    it 'check creating new product with correct user_data and exists correct product_data' do
      product = ProductFunctions.create_new_product(StaticData::TOKEN)
      http.request(product[0]) # first creating
      response = http.request(product[0]) # second creating
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['errors'].empty?).to be_truthy
      expect(JSON.parse(response.body)['product']['id']).to be_truthy
      expect(JSON.parse(response.body)['product']['name']).to eq(product[1])
    end
  end

  describe 'Delete product' do
    it 'check deleting product after product create' do
      product = ProductFunctions.create_new_product(StaticData::TOKEN)
      new_product_response = http.request(product[0])
      product_id_for_deleting = JSON.parse(new_product_response.body)['product']['id']
      request = ProductFunctions.delete_product(StaticData::TOKEN, product_id_for_deleting)
      response = http.request(request)
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['product']).to eq(product_id_for_deleting.to_s)
      expect(JSON.parse(response.body)['errors'].empty?).to be_truthy
    end
  end

  describe 'Get Products' do
    it 'get all products after creating' do
      product = ProductFunctions.create_new_product(StaticData::TOKEN)
      new_product_data = http.request(product[0])
      products = ProductFunctions.get_all_products(StaticData::TOKEN)
      expect(products[JSON.parse(new_product_data.body)['product']['id']]['name']).to eq(JSON.parse(new_product_data.body)['product']['name'])
    end
  end

  describe 'Edit product' do
    it 'edit product after creating' do
      product = ProductFunctions.create_new_product(StaticData::TOKEN)
      product_name_for_updating = 30.times.map { StaticData::ALPHABET.sample }.join
      new_product_data = http.request(product[0])
      product_data = {id: JSON.parse(new_product_data.body)['product']['id'], name: product_name_for_updating}
      request = ProductFunctions.update_product(StaticData::TOKEN, product_data)
      response = http.request(request)
      products = ProductFunctions.get_all_products(StaticData::TOKEN)
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['errors'].empty?).to be_truthy
      expect(products[JSON.parse(new_product_data.body)['product']['id']]['name']).to eq(product_name_for_updating)
    end
  end
end