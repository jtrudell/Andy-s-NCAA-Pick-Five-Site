# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ncaa_scrape'

scrape = NCAABasketball.new

scrape.team_names.each do |team|
  Team.create(name: team, wins: scrape.team_wins(team))
end

users = User.create([
  {name: 'Andy B'},
  {name: 'Mark N'},
  {name: 'Jason C'},
  {name: 'Kevin C'},
  {name: 'Rob S'},
  {name: 'Brian C'},
  {name: 'Drew K'},
  {name: 'Matt J'},
  {name: 'Mitch M'},
  {name: 'Joe M'},
  {name: 'Jeremy N'},
  {name: 'Sean B'},
  {name: 'Adam R'},
  {name: 'Matt M'},
  {name: 'Mark K'},
  {name: 'Mark Double K'},
  {name: 'Matt W'},
  {name: 'Kevin B'}
  ])

users.each do |user|
  5.times do
    user.picks.create(team_id: rand(0..Team.count))
  end
end
