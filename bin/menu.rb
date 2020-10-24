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

   def deck_menu(deck)
      #sub menu to add, remove or view cards
      response = nil
      system("sleep 0.5")
      until response == "exit" do
         self.line_spacing
         self.deck_menu_prompts
         response = gets.strip.downcase
         self.clear_screen
         case
         when response == "add"
            print "please enter a card name: "
            response = gets_response
            deck.add_card(name: response)
         when response == "remove"
            print "please enter a card name, or ALL for all cards: "
            response = gets_response
            if response.downcase == "all"
               deck.remove_all_cards
            else
               deck.remove_card(name: response)
            end
         when response == "owned"
            deck.list_all_cards
         when response == "all"
            puts "All current Magic Cards:"
            puts ""
            Card.all_names
         when response == "sample"
            deck.build_sample_deck
            puts "Your deck has been populated."
         when response != "exit"
            puts "Sorry, I did not understand your request"
         when response == "exit"
            puts " " * 24 + "Main Menu"
         end
      end
   end

   def main_menu
      user = self.log_in
      self.intro
      response = nil

      until response == "exit" do
         system('sleep 0.5')
         self.line_spacing
         self.main_menu_options
         response = gets.strip.downcase
         self.clear_screen
         case
         when response == "list"
            user.deck_names.length > 0 ? puts(user.deck_names) : puts("No decks were found!")
         when response == "create"
            print "Please name your new deck: "
            deck_name = gets.strip
            user.create_deck(name: deck_name)
         when response == "remove"
            print "Please enter the deck to remove: "
            deck_name = gets.strip
            user.destroy_deck_if_owned(name: deck_name)
         when response == "modify"
            print "Please enter the deck to modify: "
            deck_name = gets.strip
            deck = Deck.find_by(name: deck_name)
            user.owns_deck?(name: deck_name) ? self.deck_menu(deck) : user.deck_not_owned_message
         when response == "play"
            print "Please enter the deck you would like to use: "
            deck_name = gets.strip
            user.owns_deck?(name: deck_name) ? self.run_game(deck_name) : user.deck_not_owned_message
         when response != "exit"
            puts "Sorry, I did not understand your request"
         end
      end
      self.end
   end
   
   def run_game(deck_name)
      game = Game.new(Deck.find_by(name: deck_name))
      game.play
      puts ""
      game.result_message
   end
   
   def line_spacing
      puts ""
      puts "<>" * 32
      puts ""
   end

   def intro_banner
      system 'clear'
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
      system('sleep 0.2')
      self.line_spacing
   end

   def intro
      self.intro_banner
      self.greeting
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
      system 'clear'
      self.banner
   end

   def end
      system 'clear'
      puts '╔════╗╔╗           ╔╗           ╔═╗               ╔╗                     ╔╗'.colorize(:red)
      puts '║╔╗╔╗║║║           ║║           ║╔╝               ║║                     ║║'.colorize(:yellow)
      puts '╚╝║║╚╝║╚═╗╔══╗ ╔═╗ ║║╔╗╔══╗    ╔╝╚╗╔══╗╔═╗    ╔══╗║║ ╔══╗ ╔╗ ╔╗╔╗╔═╗ ╔══╗║║'.colorize(:green) 
      puts '  ║║  ║╔╗║╚ ╗║ ║╔╗╗║╚╝╝║══╣    ╚╗╔╝║╔╗║║╔╝    ║╔╗║║║ ╚ ╗║ ║║ ║║╠╣║╔╗╗║╔╗║╚╝'.colorize(:cyan)
      puts ' ╔╝╚╗ ║║║║║╚╝╚╗║║║║║╔╗╗╠══║     ║║ ║╚╝║║║     ║╚╝║║╚╗║╚╝╚╗║╚═╝║║║║║║║║╚╝║╔╗'.colorize(:blue)
      puts ' ╚══╝ ╚╝╚╝╚═══╝╚╝╚╝╚╝╚╝╚══╝     ╚╝ ╚══╝╚╝     ║╔═╝╚═╝╚═══╝╚═╗╔╝╚╝╚╝╚╝╚═╗║╚╝'.colorize(:magenta)
      puts '                                              ║║          ╔═╝║       ╔═╝║'.colorize(:blue)  
      puts '                                              ╚╝          ╚══╝       ╚══╝'.colorize(:cyan)
      system 'sleep 1.5'
      system 'clear'
   end 
   
   def gets_response
      gets.strip
   end
end