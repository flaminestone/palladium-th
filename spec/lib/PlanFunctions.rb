require 'net/http'
require 'json'
class PlanFunctions

  # @param [Hash] args must has :plan_data[name] with plan name and plan_data[product_id] with product id
  def self.create_new_plan(*args)
    args.first['plan_data[name]'] ||= 30.times.map { StaticData::ALPHABET.sample }.join
    request = Net::HTTP::Post.new('/plan_new', 'Content-Type' => 'application/json')
    request.set_form_data(args.first)
    [request, args.first['plan_data[name]']]
  end

  # @param [Hash] args must has :plan_data[name] with plan name and plan_data[product_id] with product id
  def self.get_plans(*args)
    uri = URI(StaticData::MAINPAGE + '/plans')
    params = args.first
    uri.query = URI.encode_www_form(params)
    hash_with_products = {}
    result = JSON.parse(Net::HTTP.get_response(uri).body)
    if result['errors'].nil?
      JSON.parse(Net::HTTP.get_response(uri).body)['plans'].map do |current_plan|
        hash_with_products.merge!({current_plan['id'] => {'id' => current_plan['id'],
                                                          'name' => current_plan['name'],
                                                          'product_id' => current_plan['product_id'],
                                                          'created_at' => current_plan['created_at'],
                                                          'updated_at' => current_plan['updated_at']}})
      end
      hash_with_products
    else
      result
    end
  end
  #
  #
  # # @param [Hash] account like a {:email => 'email_from_account', :password => 'password_from_account'}
  # # @param [Integer] id is a id of product for deleting
  # # return hash which keys - id of product, values - is a hash {'name': 'product_name'}
  # def self.delete_product(account, id)
  #   uri = URI(StaticData::MAINPAGE + '/product_delete')
  #   uri.query = URI.encode_www_form({"user_data[email]": account[:email], "user_data[password]":  account[:password], "product_data[id]": id})
  #   Net::HTTP::Delete.new(uri)
  # end
  #
  # # @param [Hash] account like a {:email => 'email_from_account', :password => 'password_from_account'}
  # # @param [Hash] product_data like a {:id => product_id, :name => product_name}
  # def self.update_product(account, product_data)
  #   request = Net::HTTP::Post.new('/product_edit', 'Content-Type' => 'application/json')
  #   request.set_form_data({"user_data[email]": account[:email], "user_data[password]":  account[:password],
  #                          "product_data[id]": product_data[:id], "product_data[name]": product_data[:name]})
  #   request
  # end
  #
  # # @param [Hash] account like a {:email => 'email_from_account', :password => 'password_from_account'}
  # # @param [Integer] id is a id of product for deleting
  # def self.show_product(account, id)
  #   uri = URI(StaticData::MAINPAGE + '/product')
  #   uri.query = URI.encode_www_form({"user_data[email]": account[:email], "user_data[password]":  account[:password], "product_data[id]": id})
  #   result = JSON.parse(Net::HTTP.get_response(uri).body)
  #   if result['product'].empty?
  #     {'product': [], 'errors': result['errors']}
  #   else
  #     {id: result['product']['id'], name: result['product']['name'], created_at: result['product']['created_at'], updated_at: result['product']['updated_at']}
  #   end
  # end
end