# Welcome to the Magic the Gathering Deck Builder!

## Description

This application allows a user to create decks, populate them with cards, and do battle with a computer opponent!  It is built entirely with Ruby, and uses Sqlite3 and ActiveRecord to manage the database.  The purpose of this application is to give the user full CRUD, allowing them to create, read, update and destroy both their decks, and the cards within them.


## Install Instructions

1. Start by running `bundle install` to install/update all gems.
2. Migrate tables by running `rake db:migrate`.
3. Plant seed data from API by running `rake db:seed`.
4. Start the application by running `ruby bin/run.rb` from the root directory of the project.

## Video Demonstration

https://youtu.be/OVeGIEJM0c4

## Contributors

Created by Jesse Vaughn and Alec Grey

## License

Copyright 2020 Jesse Vaughn & Alexander Grey

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
