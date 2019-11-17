require 'sinatra'
require 'bundler'
require 'sinatra/json'
require 'sinatra/cross_origin'


Bundler.require
#require 'database'

#database
require 'data_mapper'

DataMapper.setup (:default, ENV['DATABASE_URL'] || "postgres://postgres:postgres@localhost/[postgres]")


class Company
  include DataMapper::Resource

  property :id, Serial
  property:name, String, :required => true
  property:adress,String,:required => true
  property:city,String, :required => true
  property:country,String,:required => true
  property:email,String
  property:phoneNumber,Numeric
  has n, :owners, :constraint => :destroy

end

class Owner
  include DataMapper::Resource

  property :id,Serial
  property:name,String, :required => true
  property:company_id,Integer, :required =>true

  belongs_to:company
end

DataMapper.finalize
DataMapper.auto_migrate!


#DataMapper.setup(:default,'sqlite::memory:')
#DataMapper.finalize
#DataMapper.auto_upgrade!

set :allow_origin, "*"
set :allow_methods, "GET,HEAD,POST, PUTCH, DELETE,OPTIONS"
set :allow_headers, "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
set :expose_headers, "location,link"





get '/' do
  'Welcome to company'
end

#get a list of all companies
get '/companies'do
  content_type :json

  companies = Company.all
  companies.to_json
end

#get details about a company
get '/companies/:id'do
    content_type :json
  company = Company.get params[:id]
  owner = company.owners
  company.to_json

end



#add a new company
post '/companies'do
  content_type :json
  company = Company.new
  company.name  = params[:name]
  company.adress = params[:adress]
  company.country  = params[:country]
  company.city = params[:city]
  company.email = params[:email]
  company.phoneNumber = params[:phoneNumber]
  if company.save
    status 201
  else
    status 500
    json company.errors.full_messages
  end
end
#add owner to the company
post '/owners'do
  content_type :json
  owner = Owner.new params[:owner]
  if owner.save
    status 201
  else
    status 500
    json owner.errors.full_messages
  end
end


#update a company
put '/companies/:id'do
  content_type :json
  company = Company.get params[:id]
  if company.update params[:company]
    status 200
    json 'Company was updated'
  else
    status 500
    json company.errors.full_messages
  end
end

#delete a company
delete '/companies/:id'do
  content_type :json
  company = Company.get params[:id]
  if company.destroy
    status 200
    json'Company was deleted'
  else
    status 500
    json 'There was problem removing the company'
  end
end
