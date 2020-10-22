Make sure to create a good README.md with a short description, install instructions, 
a contributor's guide and a link to the license for your code.

## Welcome to the Magic the Gathering Deck Builder!

### Description

This application allows a user to create decks, populate them with cards, and do battle with a computer opponent!  It is built entirely with Ruby, and uses Sqlite3 and ActiveRecord to manage the database.  The purpose of this application is to give the user full CRUD, allowing them to create, read, update and destroy both their decks, and the cards within them.


### Install Instructions

1. Start by running `bundle install` to install/update all gems.
2. Migrate tables by running `rake db:migrate`.
3. Plant seed data from API by running `rake db:seed`.
4. Start the application by running `ruby bin/run.rb` from the root directory of the project.