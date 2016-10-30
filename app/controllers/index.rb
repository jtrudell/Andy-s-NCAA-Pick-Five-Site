get '/' do
  redirect '/2016'
end

before '/2016' do
  Team.update_wins(2016) if Time.now > Time.new(2016, 11, 5)
  @users = User.where(year: 2016).order('name')
  @standings = User.standings(2016)
end

get '/:year' do
  @year = params[:year].to_i
  redirect '/' if Time.now.year < @year
  @users = User.where(year: @year).order('name')
  @standings = User.standings(@year)
  @previous_year_teams = Team.where(year: @year - 1)
  erb :"index"
end

get '/picks/:year' do
  year = params[:year].to_i
  redirect '/' if Time.now.year != year
  @team_list = Team.two_columns(year)
  @previous_year_teams = Team.where(year: year - 1)
  erb :"signup"
end

post '/picks/:year' do
  year = params[:year].to_i
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
  redirect '/' if Time.now.year != params[:year]
  @user = User.find(params[:id])
  if @user.present?
    @picks = @user.picks
    erb :"picks"
  else
    redirect '/'
  end
end
