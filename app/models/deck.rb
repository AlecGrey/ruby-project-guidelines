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
       self.cards << Card.find_by(name: name)
    end

    def remove_card(name:)
        #removes card(s) from a players deck
        card_to_delete =  Card.find_by(name: name)
        self.cards.delete(card_to_delete)
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
end