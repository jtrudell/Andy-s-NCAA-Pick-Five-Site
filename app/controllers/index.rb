get '/' do
  Team.update_wins
  @users = User.all
  @standings = User.standings
  erb :"index"
end
