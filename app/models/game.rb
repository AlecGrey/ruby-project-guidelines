class Game

    attr_reader :user_deck, :result, :computer_deck

    @@all =[]

    def initialize(deck)
        @user_deck = deck
        @result = nil
        @computer_deck = self.populate_deck
    end

    def populate_deck
        deck = []
        40.times {|i| deck << Card.all.sample}
        deck
    end

    def computers_power
        card_types = self.computer_deck.map {|card| card.card_type}
        card_types.select {|card| card.include?("Creature")}.count
    end

    def users_power
        card_types = user_deck.cards.map {|card| card.card_type}
        card_types.select {|card| card.include?("Creature")}.count
    end

    def play
        @result = self.users_power > self.computers_power ? "win" : "loss"
        return "Congratulations" if self.result == "win"
        return "Sucks, dude." if self.result == "loss"
    end

end
