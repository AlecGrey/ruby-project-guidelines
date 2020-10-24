require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

desc 'Empty the User, Deck, and DeckCard tables'
task :clear do
  User.destroy_all
  Deck.destroy_all
  DeckCard.destroy_all
  puts "User, Deck and DeckCard data have been destroyed."
end
