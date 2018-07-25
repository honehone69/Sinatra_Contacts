require 'rubygems'
require 'bundler'

Bundler.require

set :database, {adapter: "sqlite3", database: "contacts.foo.sqlite3"}

class Contact < ActiveRecord::Base
  validates_presence_of :name
end

get '/' do
    @now = Time.now
    @contacts = Contact.all
    erb :index
end

get '/contact_new' do
    erb :contact_form
end

post '/contacts' do
    puts "送信されたデータ"
    p params
    
    name = params[:name]
    
    #DBに保存
    contact = Contact.new({name: name})
    contact.save
    
    redirect '/'
end