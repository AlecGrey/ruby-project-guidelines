require 'pry'

class Menu

   def self.run
      menu = Menu.new
      menu.main_menu
   end

   attr_reader :user

   def log_in
    #asks for user name and returns the user object
    puts "Please enter your username"
    user_input = gets.strip
    return User.find_or_create_by(name: user_input)
   end

   def greeting
    #returns a welcome message upon log in
    puts ""
    puts "Welcome to the Magic the Gathering Deck Builder"
   end

   def main_menu_options
    #asks whether user would like to create, change, or view a deck
    puts "Would you like to:"
    puts ""
    puts "LIST your current decks"
    puts "CREATE a deck"
    puts "REMOVE a deck"
    puts "MODIFY an existing deck"
    puts "EXIT the program"
    puts ""
   end

   def deck_names(user_object)
      #will show the user thier decks
      decks = user_object.decks.map {|deck| deck.name}
      decks.length == 0 ? nil : decks
   end
   
   def deck_menu_prompts
      #puts a prompt to add, remove or view cards
      puts "Select an action:"
      puts ""
      puts "ADD - add a card"
      puts "REMOVE - remove a card"
      puts "OWNED - view owned cards"
      puts "ALL - view all cards"
      puts "EXIT - return to the main menu"
      puts ""
   end

   def deck_menu(deck_obj)
      #sub menu to add, remove or view cards
      response = nil

      until response == "exit" do
         self.line_spacing
         self.deck_menu_prompts
         response = gets.strip
         response = response.downcase

         case
         when response == "add"
            print "please enter a card name: "
            card = gets.strip
            card_obj = Card.find_by(name: card)
            if card_obj
               deck_obj.cards << card_obj
            else
               puts ""
               puts "that cards was not found."
            end
         when response == "remove"
            print "please enter a card name: "
            card = gets.strip
            card_obj = Card.find_by(name: card)
            if deck_obj.cards.include?(card_obj)
               deck_obj.cards.delete(card_obj)
            else
               puts ""
               puts "that cards was not found."
            end
         when response == "owned"
            if deck_obj.cards.length > 0
               puts ""
               puts "your deck includes:"
               deck_obj.cards.each {|card| puts card.name}
            else
               puts "no cards were found!"
            end
         when response == "all"
            puts ""
            puts "All current Magic Cards:"
            Card.all_names
         end
      end
   end

   def main_menu
      user = self.log_in
      self.greeting
      response = nil

      until response == "exit" do
         self.line_spacing
         self.main_menu_options
         response = gets.strip.downcase

         case
         when response == "list"
            puts ""
            self.deck_names(user) ? puts(self.deck_names(user)) : puts("No decks were found!")
         when response == "create"
            print "Please name your new deck: "
            deck_name = gets.strip
            user.decks << Deck.create(name: deck_name)
         when response == "remove"
            print "Please enter the deck to remove: "
            deck_name = gets.strip
            if self.deck_names(user).include?(deck_name)
               user.decks.delete(Deck.find_by(name: deck_name))
            else
               puts ""
               puts "Sorry, that deck was not found."
            end
         when response == "modify"
            print "Please enter the deck to modify: "
            deck_name = gets.strip
            if self.deck_names(user).include?(deck_name)
               self.deck_menu(Deck.find_by(name: deck_name))
            else
               puts ""
               puts "Sorry, that deck was not found."
            end
         when response != "exit"
            puts ""
            puts "Sorry, I did not understand your request"
         end
      end
   end
   
   def line_spacing
      puts ""
      puts "<>" * 30
      puts ""
   end
end