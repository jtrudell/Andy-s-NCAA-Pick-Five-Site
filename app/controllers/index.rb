get '/' do
  redirect '/2016'
end

before '/2016' do
  Team.update_wins(2016)
  @users = User.where(year: 2016).order('name')
  @standings = User.standings(2016)
end

get '/:year' do
  year = params[:year].to_i
  @users = User.where(year: year).order('name')
  @standings = User.standings(year)
  erb :"index"
end

get '/picks/:year' do
  year = params[:year].to_i
  redirect '/' if Time.now.year != year
  @team_list = Team.two_columns(year)
  erb :"signup"
end

post '/picks/:year' do
  year = params[:year].to_i
  redirect '/' if Time.now.year != year
  @user = User.new(name: params['name'], year: year)
  teams = params['teams']
  if teams.nil? || teams.count != 5
    flash[:notice] = "You selected #{teams.count} teams: #{teams.keys}. You must pick 5 teams."
    redirect "/picks/#{year}"
  end
  @picks = Pick.generate(@user, teams)
  if @user.save
    redirect "/users/#{@user.id}/picks/#{year}"
  else
    flash[:notice] = "User name #{params['name']} exists. Try another name."
    redirect "/picks/#{year}"
  end
end

get '/users/:id/picks/:year' do
  @user = User.find(params[:id])
  if @user.present?
    @picks = @user.picks
    erb :"picks"
  else
    redirect '/'
  end
end
