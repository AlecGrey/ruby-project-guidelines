class Card < ActiveRecord::Base
    has_many :deck_cards
    has_many :decks, through: :deck_cards

    def self.all_names
        #returns the names of all cards available
    end

    def self.all_names_by_color(color)
        #returns the names of all the cards that have same color as one called
    end

    def self.all_names_by_type(type)
         #returns the names of all the cards that have same type as one called
    end
end