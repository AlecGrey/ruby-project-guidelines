class Card < ActiveRecord::Base
    has_many :deck_cards
    has_many :decks, through: :deck_cards

    def self.all_names
        #returns the names of all cards available
        cards = Card.all.map {|card| card.name}
        self.list_cards(cards)
    end

    def self.all_names_by_color(color)
        #returns the names of all the cards that have same color as one called
        cards = Card.all.select {|card| card.color == color}.map {|card| card.name}
        self.list_cards(cards)
    end

    def self.all_names_by_type(type)
         #returns the names of all the cards that have same type as one called
         cards = Card.all.select {|card| card.card_type == type}.map {|card| card.name}
         self.list_cards(cards)
    end

    def self.list_cards(arr)
        arr.each {|card_name| puts card_name}
    end
end