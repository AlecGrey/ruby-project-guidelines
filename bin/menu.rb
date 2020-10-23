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
    puts "PLAY a game"
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
      puts "SAMPLE - populates your deck with 40 random cards"
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
         system("sleep 0.5")
         self.deck_menu_prompts
         response = gets.strip
         response = response.downcase

         case
         when response == "add"
            self.clear_screen
            print "please enter a card name: "
            card = gets.strip
            card_obj = Card.find_by(name: card)
            if card_obj
               deck_obj.cards << card_obj
               system("sleep 0.5")
            else
               puts "that cards was not found."
               system("sleep 0.5")
            end
         when response == "remove"
            self.clear_screen
            print "please enter a card name, or ALL for all cards: "
            card = gets.strip
            card_obj = Card.find_by(name: card)
            if card.downcase == "all"
               deck_obj.cards.delete_all
            elsif deck_obj.cards.include?(card_obj)
               deck_obj.cards.delete(card_obj)
               system("sleep 0.5")
            else
               puts "that cards was not found."
               system("sleep 0.5")
            end
         when response == "owned"
            self.clear_screen
            if deck_obj.cards.length > 0
               puts "your deck includes:"
               puts ""
               deck_obj.cards.each {|card| puts card.name}
               system("sleep 0.5")
            else
               puts "no cards were found!"
               system("sleep 0.5")
            end
         when response == "all"
            self.clear_screen
            puts "All current Magic Cards:"
            puts ""
            Card.all_names
            system("sleep 0.5")
         when response == "sample"
            self.clear_screen
            deck_obj.build_sample_deck
            puts ""
            puts "Your deck has been populated."
            system("sleep 0.5")
         when response != "exit"
            self.clear_screen
            puts "Sorry, I did not understand your request"
            system("sleep 0.5")
         when response == "exit"
            self.clear_screen
            puts "                        Main Menu"
         end
      end
   end

   def main_menu
      user = self.log_in
      self.intro_banner
      system("sleep 0.5") 
      self.greeting
      system("sleep 0.5") 
      response = nil

      until response == "exit" do
         self.line_spacing
         system("sleep 0.5")
         self.main_menu_options
         response = gets.strip.downcase

         case
         when response == "list"
            self.clear_screen
            self.deck_names(user) ? puts(self.deck_names(user)) : puts("No decks were found!")
         when response == "create"
            self.clear_screen
            print "Please name your new deck: "
            deck_name = gets.strip
            user.decks << Deck.create(name: deck_name)
            system("sleep 0.5")
         when response == "remove"
            self.clear_screen
            print "Please enter the deck to remove: "
            deck_name = gets.strip
            if self.deck_names(user).include?(deck_name)
               user.decks.delete(Deck.find_by(name: deck_name))
               system("sleep 0.5")
            else
               puts "Sorry, that deck was not found."
               system("sleep 0.5")
            end
         when response == "modify"
            self.clear_screen
            print "Please enter the deck to modify: "
            deck_name = gets.strip
            if self.deck_names(user).include?(deck_name)
               self.deck_menu(Deck.find_by(name: deck_name))
               system("sleep 0.5")
            else
               puts "Sorry, that deck was not found."
               system("sleep 0.5")
            end
         when response == "play"
            self.clear_screen
            print "Please enter the deck you would like to use: "
            deck_name = gets.strip
            if self.deck_names(user).include?(deck_name)
               game = Game.new(Deck.find_by(name: deck_name))
               game.play
               puts "Congratulations! You have bested our computer." if game.result == "win"
               puts "You lost to the computer." if game.result == "loss"
               system("sleep 0.5")
            else
               puts "Sorry, that deck was not found."
               system("sleep 0.5")
            end

         when response != "exit"
            self.clear_screen
            puts "Sorry, I did not understand your request"
            system("sleep 0.5")
         end
      end
   end
   
   def line_spacing
      puts ""
      puts "<>" * 30
      puts ""
   end

   def intro_banner
      puts "\e[H\e[2J"
      puts '╔═╗╔═╗ ╔╗ ╔═══╗    ╔═══╗        ╔╗      ╔══╗       ╔╗   ╔╗'.colorize(:red)  
      system('sleep 0.2')    
      puts '║║╚╝║║╔╝╚╗║╔═╗║    ╚╗╔╗║        ║║      ║╔╗║       ║║   ║║'.colorize(:yellow)    
      system('sleep 0.2')       
      puts '║╔╗╔╗║╚╗╔╝║║ ╚╝     ║║║║╔══╗╔══╗║║╔╗    ║╚╝╚╗╔╗╔╗╔╗║║ ╔═╝║╔══╗╔═╗'.colorize(:green)
      system('sleep 0.2')    
      puts '║║║║║║ ║║ ║║╔═╗     ║║║║║╔╗║║╔═╝║╚╝╝    ║╔═╗║║║║║╠╣║║ ║╔╗║║╔╗║║╔╝'.colorize(:cyan)
      system('sleep 0.2')    
      puts '║║║║║║ ║╚╗║╚╩═║    ╔╝╚╝║║║═╣║╚═╗║╔╗╗    ║╚═╝║║╚╝║║║║╚╗║╚╝║║║═╣║║'.colorize(:blue)
      system('sleep 0.2')    
      puts '╚╝╚╝╚╝ ╚═╝╚═══╝    ╚═══╝╚══╝╚══╝╚╝╚╝    ╚═══╝╚══╝╚╝╚═╝╚══╝╚══╝╚╝'.colorize(:magenta)
      puts ""
   end

   def banner
      puts '╔═╗╔═╗ ╔╗ ╔═══╗    ╔═══╗        ╔╗      ╔══╗       ╔╗   ╔╗'.colorize(:red)
      puts '║║╚╝║║╔╝╚╗║╔═╗║    ╚╗╔╗║        ║║      ║╔╗║       ║║   ║║'.colorize(:yellow)
      puts '║╔╗╔╗║╚╗╔╝║║ ╚╝     ║║║║╔══╗╔══╗║║╔╗    ║╚╝╚╗╔╗╔╗╔╗║║ ╔═╝║╔══╗╔═╗'.colorize(:green) 
      puts '║║║║║║ ║║ ║║╔═╗     ║║║║║╔╗║║╔═╝║╚╝╝    ║╔═╗║║║║║╠╣║║ ║╔╗║║╔╗║║╔╝'.colorize(:cyan)
      puts '║║║║║║ ║╚╗║╚╩═║    ╔╝╚╝║║║═╣║╚═╗║╔╗╗    ║╚═╝║║╚╝║║║║╚╗║╚╝║║║═╣║║'.colorize(:blue)
      puts '╚╝╚╝╚╝ ╚═╝╚═══╝    ╚═══╝╚══╝╚══╝╚╝╚╝    ╚═══╝╚══╝╚╝╚═╝╚══╝╚══╝╚╝'.colorize(:magenta)
      self.line_spacing
      
   end

   def clear_screen
      puts "\e[H\e[2J"
      self.banner
   end
end