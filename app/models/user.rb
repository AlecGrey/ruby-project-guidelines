class User < ActiveRecord::Base
    has_many :decks

    def deck_names
        #return array of deck name strings
        decks = self.decks.map {|deck| deck.name}
     end

    def create_deck(name:)
        self.decks << Deck.create(name: name)
    end

    def owns_deck?(name:)
        self.deck_names.include?(name)
    end

    def deck_not_owned_message
        puts "Sorry, that deck was not found in your collection."
    end

    def destroy_deck_if_owned(name:)
        deck = Deck.find_by(name: name)
        if self.owns_deck?(name: name)
            deck.cards.destroy_all
            self.decks.destroy(Deck.find_by(name: name)) 
        else
            self.deck_not_owned_message
        end
    end

end