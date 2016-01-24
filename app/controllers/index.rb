get '/' do
  @users = User.all
  @standings = User.standings
  erb :"index"
end
