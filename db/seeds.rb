

response_string = RestClient.get("https://api.magicthegathering.io/v1/cards")
response_hash = JSON.parse(response_string)
cards = response_hash["cards"]
arr = []
cards.each do |c|
    arr << {name: c["name"], color: c["colorIdentity"], type: c["type"]}
end

arr.each do |c| 
    Card.create(name: c[:name], color: c[:color][0], card_type: c[:type])
end