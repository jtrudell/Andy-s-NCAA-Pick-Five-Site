before '/' do
  Team.update_wins
  @users = User.all.sort { |x, y| x.name <=> y.name }
  @standings = User.standings
end

get '/' do
  erb :"index"
end

get '/signup' do
  @team_list = Team.two_columns
  erb :"signup"
end
