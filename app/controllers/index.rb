before do
  Team.update_wins # scrapes NCAA.com for current wins
  @users = User.all
  @standings = User.standings
end

get '/' do
  erb :"index"
end
