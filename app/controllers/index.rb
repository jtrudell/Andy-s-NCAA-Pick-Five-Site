before '/' do
  Team.update_wins
  @users = User.all.sort { |x, y| x.name <=> y.name }
  @standings = User.standings
end

get '/' do
  erb :"index"
end

get '/signup/new' do
  @team_list = Team.two_columns
  erb :"signup"
end

post '/signup/:year' do
  @user = User.new(name: params['name'])
  if @user.save
    @picks = Pick.generate(@user, params['teams'])
    erb :"picks"
  else
    flash[:notice] = "something when wrong! #{params}"
    redirect '/signup/new'
  end
end

