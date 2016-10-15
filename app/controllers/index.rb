before '/' do
  Team.update_wins
  @users = User.all.sort { |x, y| x.name <=> y.name }
  @standings = User.standings
end

get '/' do
  erb :"index"
end

get '/picks/:year' do
  @year = params[:year]
  @team_list = Team.two_columns
  erb :"signup"
end

post '/picks/:year' do
  @year = params[:year]
  teams = params['teams']
  if teams.nil? || teams.count != 5
    flash[:notice] = "You selected #{teams.count} teams: #{teams.keys}. You must pick 5 teams."
    redirect "/picks/#{@year}"
  end
  @user = User.new(name: params['name'])
  @picks = Pick.generate(@user, teams)
  if @user.save
    erb :"picks"
  else
    flash[:notice] = "User name #{params['name']} exists. Try another name."
    redirect "/picks/#{@year}"
  end
end

