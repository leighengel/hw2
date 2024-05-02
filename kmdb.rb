# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!
# - Note rubric explanation for appropriate use of external resources.

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)
# - You are welcome to use external resources for help with the assignment (including
#   colleagues, AI, internet search, etc). However, the solution you submit must
#   utilize the skills and strategies covered in class. Alternate solutions which
#   do not demonstrate an understanding of the approaches used in class will receive
#   significant deductions. Any concern should be raised with faculty prior to the due date.

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO! 

Movie.destroy_all
Actor.destroy_all
Studio.destroy_all

# Generate models and tables, according to the domain model.
# TODO!

# (Leigh note) Below is what I entered in my terminal 

# rails generate model Movie title:string year:integer rating:string studio:references
# rails generate model Actor name:string
# rails generate model Studio name:string
# rails generate model Casting movie:references actor:references top_billed:boolean

# rails db:migrate

# app/models/movie.rb
class Movie < ApplicationRecord
    belongs_to :studio
    has_many :castings
    has_many :actors, through: :castings
  end
  
  # app/models/actor.rb
  class Actor < ApplicationRecord
    has_many :castings
    has_many :movies, through: :castings
  end
  
  # app/models/studio.rb
  class Studio < ApplicationRecord
    has_many :movies
  end
  
  # app/models/casting.rb
  class Casting < ApplicationRecord
    belongs_to :movie
    belongs_to :actor
  end
  

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
# TODO!

# Assuming models: Movie, Actor, Studio, Casting
Movie.destroy_all
Actor.destroy_all
Studio.destroy_all
Casting.destroy_all

# Create Studio
warner_bros = Studio.create(name: "Warner Bros")

# Create Movies (In this case only three)
batman_begins = Movie.create(title: "Batman Begins", year: 2005, rating: "PG-13", studio: warner_bros)
dark_knight = Movie.create(title: "The Dark Knight", year: 2008, rating: "PG-13", studio: warner_bros)
dark_knight_rises = Movie.create(title: "The Dark Knight Rises", year: 2012, rating: "PG-13", studio: warner_bros)

# Create Actors
christian_bale = Actor.create(name: "Christian Bale")
michael_caine = Actor.create(name: "Michael Caine")
liam_neeson = Actor.create(name: "Liam Neeson")
katie_holmes = Actor.create(name: "Katie Holmes")
gary_oldman = Actor.create(name: "Gary Oldman")
heath_ledger = Actor.create(name: "Heath Ledger")
aaron_eckhart = Actor.create(name: "Aaron Eckhart")
maggie_gyllenhaal = Actor.create(name: "Maggie Gyllenhaal")
tom_hardy = Actor.create(name: "Tom Hardy")
joseph_gordon_levitt = Actor.create(name: "Joseph Gordon-Levitt")
anne_hathaway = Actor.create(name: "Anne Hathaway")

# Batman Begins Castings
Casting.create(movie: batman_begins, actor: christian_bale, top_billed: true)
Casting.create(movie: batman_begins, actor: michael_caine, top_billed: true)
Casting.create(movie: batman_begins, actor: liam_neeson, top_billed: true)
Casting.create(movie: batman_begins, actor: katie_holmes, top_billed: true)
Casting.create(movie: batman_begins, actor: gary_oldman, top_billed: true)

# The Dark Knight Castings
Casting.create(movie: dark_knight, actor: christian_bale, top_billed: true)
Casting.create(movie: dark_knight, actor: heath_ledger, top_billed: true)
Casting.create(movie: dark_knight, actor: aaron_eckhart, top_billed: true)
Casting.create(movie: dark_knight, actor: michael_caine, top_billed: true)
Casting.create(movie: dark_knight, actor: maggie_gyllenhaal, top_billed: true)

# The Dark Knight Rises Castings
Casting.create(movie: dark_knight_rises, actor: christian_bale, top_billed: true)
Casting.create(movie: dark_knight_rises, actor: gary_oldman, top_billed: true)
Casting.create(movie: dark_knight_rises, actor: tom_hardy, top_billed: true)
Casting.create(movie: dark_knight_rises, actor: joseph_gordon_levitt, top_billed: true)
Casting.create(movie: dark_knight_rises, actor: anne_hathaway, top_billed: true)


# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
# TODO!

# Query all movies (Leigh remember to use singular)
movies = Movie.includes(:studio).all

# Loop through each movie and print details
movies.each do |movie|
  puts "#{movie.title.ljust(30)} #{movie.year.to_s.ljust(15)} #{movie.rating.ljust(10)} #{movie.studio.name}"
end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!

# Query all movies and include castings and actors
movies = Movie.includes(castings: :actor).all

# Loop through each movie
movies.each do |movie|
  # Print each actor and their role in the movie
  movie.castings.each do |casting|
    puts "#{movie.title.ljust(30)} #{casting.actor.name.ljust(25)} #{casting.actor.role}"
  end
end


