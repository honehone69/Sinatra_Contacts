require 'rubygems'
require 'bundler'

Bundler.require

set :database, {adapter: "sqlite3", database: "contacts.foo.sqlite3"}
enable:sessions

class Contact < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :address
end

get '/' do
    @now = Time.now
    @contacts = Contact.all
    @message = session.delete :message
    #@message = session[:message]
    erb :index
end

get '/contact_new' do
    @contact = Contact.new
    erb :contact_form
end

post '/contacts' do
    puts "送信されたデータ"
    p params
    
    name = params[:name]
    
    #DBに保存
    @contact = Contact.new({name: name, email: params[:email], address: params[:address]})
    if @contact.save
        #true
        session[:message] = "#{name}さんを作成しました"
        redirect '/'
    else
        #false
        erb :contact_form
    end
end