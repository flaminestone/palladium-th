require_relative 'management'
include Auth
configure {
  set :server, :puma
  set :root, File.dirname(__FILE__)
  enable :static
  enable :dump_errors
  set :sessions, key: 'N&wedhSDF',
      domain: "localhost",
      path: '/',
      expire_after: 14400,
      secret: '*&(^B234'
  set :show_exceptions, false # uncomment for testing or production
}

# region pages start
get '/' do
  login_required
  erb :index
end

get '/login' do
  erb :login
end

get '/registration' do
  erb :registration
end

not_found do
  'This is nowhere to be found.'
end

error do
  'Sorry there was a nasty error - ' + env['sinatra.error'].message
end
# endregion pages

# region auth
get '/logout' do
  session[:user] = nil
  redirect '/'
end

post '/registration' do
    new_user = User.create_new(user_data)
    begin
      new_user.save if new_user.errors.empty?
      rescue
    end
    if new_user.errors.empty?
      session[:user] = user_data['email']
      status 200
    else
      status 201
      content_type :json
      new_user.errors.to_json
    end
end

post '/login' do
  if auth_success?(user_data)
    session[:user] = user_data['email']
    status 200
  else
    status 201
    content_type :json
    {user_data: user_data, errors: 'login or password is uncorrect'}.to_json # used in 'check registration page loading' test
  end
end
# endregion auth

# region product
post '/product_new' do
  if access_available?
    product = Product.create_new(product_data)
    content_type :json
    status 200
    {'product': product.values, "errors": product.errors}.to_json
  else
    status 201
    {errors: 'login or password is uncorrect'}.to_json # used in 'check registration page loading' test
  end
end

get '/products' do
  if access_available?
    products = Product.all
    content_type :json
    status 200
    {'products': products.map{|current| current.values }}.to_json
  else
    status 201
    {errors: 'login or password is uncorrect'}.to_json # used in 'check registration page loading' test
  end
end

get '/product' do
  if access_available?
    product = Product.where[id: product_data['id']]
    content_type :json
    status 200
    errors = []
    if product.nil?
      product = []
      errors = ["product is not found"]
    else
      product = product.values
    end
    {'product': product, 'errors': errors}.to_json
  else
    status 201
    {errors: 'login or password is uncorrect'}.to_json # used in 'check registration page loading' test
  end
end

delete '/product_delete' do
  if access_available?
    errors = Product.product_id_validation(product_data['id'])
    if errors.empty?
      Product[:id => product_data['id']].destroy
    end
    content_type :json
    status 200
    {'product': product_data['id'],'errors': errors }.to_json
  else
    status 201
    {errors: 'login or password is uncorrect'}.to_json # used in 'check registration page loading' test
  end
end

# you can change only name of product now
post '/product_edit' do
  if access_available?
    product = Product.new(:name => product_data['name'])
    content_type :json
    status 200
    if product.valid?
      Product.where(:id => product_data['id']).update(:name => product_data['name'])
      {'product': product_data['id'],'errors': [] }.to_json
    else
      {'product': product_data['id'],'errors': product.errors }.to_json
    end
  else
    status 201
    {errors: 'login or password is uncorrect'}.to_json # used in 'check registration page loading' test
  end
end
# endregion product

# region plans
post '/plan_new' do
  if access_available?
    plan = Plan.create_new(plan_data)
    content_type :json
    status 200
    {'plan': plan.values, "errors": plan.errors}.to_json
  else
    status 201
    {errors: 'login or password is uncorrect'}.to_json # used in 'check registration page loading' test
  end
end

# return all plans from one product (product_id)
get '/plans' do
  if access_available?
    errors = Product.product_id_validation(plan_data['product_id'])
    plans = []
    plans = Product[:id => plan_data['product_id']].plans if errors.empty?
    content_type :json
    status 200
    {'plans': plans.map{|plan| plan.values}, "errors": errors}.to_json
  else
    status 201
    {errors: 'login or password is uncorrect'}.to_json # used in 'check registration page loading' test
  end
end


delete '/plan_delete' do
  if access_available?
    errors = Plan.plan_id_validation(plan_data['id'])
    if errors.empty?
      Plan[:id => plan_data['id']].destroy
    end
    content_type :json
    status 200
    {'plan': plan_data['id'],'errors': errors }.to_json
  else
    status 201
    {errors: 'login or password is uncorrect'}.to_json # used in 'check registration page loading' test
  end
end
# endregion plans

def login_required
  if session[:user]
    return true
  else
    redirect '/login'
    return false
  end
end

def current_user
  if session[:user]
    session[:user]
  end
end

def user_data
  begin
    params['user_data']
  rescue Exception
    error
  end
end

def product_data
    params['product_data']
end

def plan_data
    params['plan_data']
end

def access_available?
  auth_status = false
  if user_data_strong?
    auth_status = auth_success?(user_data)
  end
  !session[:user].nil? || auth_status
end

def user_data_strong?
  if params.key?('user_data')
    params['user_data'].key?('email') && params['user_data'].key?('password')
  else
    false
  end
end
