# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# SEEDS FOR 2015/2016 SEASON BASED ON ANDY'S SPREADSHEET
require 'ncaa_scrape'

scrape = NCAABasketball.new

scrape.team_names.each do |team|
  Team.create(name: team, wins: scrape.team_wins(team), year: 2015)
  Team.create(name: team, year: 2016)
end

users = User.create([
  {name: 'Andy B', year: 2015},
  {name: 'Mark N', year: 2015},
  {name: 'Jason C', year: 2015},
  {name: 'Kevin C', year: 2015},
  {name: 'Rob S', year: 2015},
  {name: 'Brian C', year: 2015},
  {name: 'Drew K', year: 2015},
  {name: 'Matt J', year: 2015},
  {name: 'Mitch M', year: 2015},
  {name: 'Joe M', year: 2015},
  {name: 'Jeremy N', year: 2015},
  {name: 'Sean B', year: 2015},
  {name: 'Adam R', year: 2015},
  {name: 'Matt M', year: 2015},
  {name: 'Mark K', year: 2015},
  {name: 'Mark Double K', year: 2015},
  {name: 'Matt W', year: 2015},
  {name: 'Kevin B', year: 2015}
  ])

Pick.create([
  {user_id: 1, team_id: 17}, #texas
  {user_id: 1, team_id: 40}, #indiana
  {user_id: 1, team_id: 7},
  {user_id: 1, team_id: 74}, #georgetown
  {user_id: 1, team_id: 21}, #michigan state

  {user_id: 2, team_id: 33},
  {user_id: 2, team_id: 39},
  {user_id: 2, team_id: 7},
  {user_id: 2, team_id: 3},
  {user_id: 2, team_id: 9}, #maryland

  {user_id: 3, team_id: 3}, #kansas
  {user_id: 3, team_id: 7},
  {user_id: 3, team_id: 90}, #lsu
  {user_id: 3, team_id: 1}, #oklahoma
  {user_id: 3, team_id: 33},

  {user_id: 4, team_id: 33},
  {user_id: 4, team_id: 9}, #maryland
  {user_id: 4, team_id: 7},
  {user_id: 4, team_id: 39}, #california
  {user_id: 4, team_id: 194}, #old dominion

  {user_id: 5, team_id: 79}, #ohio state
  {user_id: 5, team_id: 33}, #michigan
  {user_id: 5, team_id: 42}, #witchita st
  {user_id: 5, team_id: 7}, #north carolina
  {user_id: 5, team_id: 34}, #pittsburgh

  {user_id: 6, team_id: 9},
  {user_id: 6, team_id: 21},
  {user_id: 6, team_id: 3},
  {user_id: 6, team_id: 7},
  {user_id: 6, team_id: 179}, #ball state

  {user_id: 7, team_id: 9},
  {user_id: 7, team_id: 90},
  {user_id: 7, team_id: 7},
  {user_id: 7, team_id: 39},
  {user_id: 7, team_id: 58}, #UConn

  {user_id: 8, team_id: 9},
  {user_id: 8, team_id: 21},
  {user_id: 8, team_id: 7},
  {user_id: 8, team_id: 39},
  {user_id: 8, team_id: 33},

  {user_id: 9, team_id: 3},
  {user_id: 9, team_id: 9},
  {user_id: 9, team_id: 7},
  {user_id: 9, team_id: 102}, #UAB
  {user_id: 9, team_id: 128}, #Marquette

  {user_id: 10, team_id: 7},
  {user_id: 10, team_id: 1},
  {user_id: 10, team_id: 33},
  {user_id: 10, team_id: 21},
  {user_id: 10, team_id: 58},

  {user_id: 11, team_id: 42},
  {user_id: 11, team_id: 9},
  {user_id: 11, team_id: 13}, #iowa st
  {user_id: 11, team_id: 48}, #butler
  {user_id: 11, team_id: 163}, #missouri

  {user_id: 12, team_id: 17},
  {user_id: 12, team_id: 7},
  {user_id: 12, team_id: 39},
  {user_id: 12, team_id: 33},
  {user_id: 12, team_id: 28}, #duke

  {user_id: 13, team_id: 39}, #california
  {user_id: 13, team_id: 26}, #baylor
  {user_id: 13, team_id: 3}, #kansas
  {user_id: 13, team_id: 12}, #virginia
  {user_id: 13, team_id: 33},

  {user_id: 14, team_id: 7},
  {user_id: 14, team_id: 3},
  {user_id: 14, team_id: 1},
  {user_id: 14, team_id: 39},
  {user_id: 14 , team_id: 40},

  {user_id: 15, team_id: 40},
  {user_id: 15, team_id: 3},
  {user_id: 15, team_id: 7},
  {user_id: 15, team_id: 58},
  {user_id: 15, team_id: 39},

  {user_id: 16, team_id: 9},
  {user_id: 16, team_id: 35}, #valpo
  {user_id: 16, team_id: 3},
  {user_id: 16, team_id: 7},
  {user_id: 16, team_id: 177}, #tenn state

  {user_id: 17, team_id: 3},
  {user_id: 17, team_id: 84}, #tenn
  {user_id: 17, team_id: 161}, #harvard
  {user_id: 17, team_id: 42},
  {user_id: 17, team_id: 17},

  {user_id: 18, team_id: 7},
  {user_id: 18, team_id: 9},
  {user_id: 18, team_id: 8}, #texas a&m
  {user_id: 18, team_id: 90},
  {user_id: 18, team_id: 39}
  ])
