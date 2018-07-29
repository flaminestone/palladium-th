require 'net/http'
require 'json'
class CaseFunctions
  # @param [Hash] args must has :id with exist product id

  def self.get_cases(http, options = {})
    responce = if options[:id]
                 http.post_request('/api/cases', case_data: { suite_id: options[:id] })
               else
                 http.post_request('/api/cases', case_data: { product_id: options[:product_id], run_id: options[:run_id] })
               end
    AbstractCasePack.new(responce)
  end

  def self.delete_case(http, options = {})
    http.post_request('/api/case_delete', case_data: { id: options[:id] })
  end

  def self.update_case(http, options = {})
    responce = if options[:id]
      http.post_request('/api/case_edit', case_data: { id: options[:id], name: options[:name] })
    else
      http.post_request('/api/case_edit', case_data: { result_set_id: options[:result_set_id], name: options[:name] })
               end
    AbstractCase.new(responce)
  end
end
