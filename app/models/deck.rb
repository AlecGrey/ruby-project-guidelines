class Deck < ActiveRecord::Base
    belongs_to :user
    has_many :deck_cards
    has_many :cards, through: :deck_cards

    def build_sample_deck
        self.cards.delete_all
        40.times {|i| self.cards << Card.all.sample}
    end
    
    def add_card(name:)
        #adds card(s) to a players deck
        card_obj = Card.find_by(name: name)
        if card_obj
            self.cards << card_obj
        else
            self.card_not_found
        end
    end

    def remove_card(name:)
        #removes card(s) from a players deck
        card = Card.find_by(name: name)
        self.cards.include?(card) ? self.cards.destroy(card) : self.card_not_found
    end

    def remove_all_cards
        self.cards.destroy_all
    end

    def size
        #returns number of cards in this deck
        self.cards.size
    end

    def color
        #returns color that has highest instance
        # self.cards.max_by{|c| c.color}.color
        color = {}
        self.cards.each do |card|
            color[card.color] ? color[card.color] += 1 : color[card.color] = 1
        end
        color.max_by {|k,v| v}[0]
    end

    def list_all_cards
        if self.cards.length > 0
            puts "your deck includes:"
            puts ""
            self.cards.each {|card| puts card.name}
        else
            puts "no cards were found!"
        end
    end

    def card_not_found
        puts ""
        puts "that card was not found."
    end
end