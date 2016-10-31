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
  @teams = Team.where(year: year).order('name')
  @previous_year_teams = Team.where(year: year - 1)
  erb :"signup"
end

post '/picks/:year' do
  year = params[:year].to_i
  @user = User.new(name: params['name'].titleize, year: year)
  teams = [
            params['pickone'],
            params['picktwo'],
            params['pickthree'],
            params['pickfour'],
            params['pickfive']
          ]
  teams.select! { |team| team != "" }
  if teams.count != 5
    flash[:notice] = "You selected #{teams.count} teams. You must pick 5 teams."
    redirect "/picks/#{year}"
  end
  @picks = Pick.generate(@user, teams)
  if user.errors[:base].any?
    flash[:notice] = @user.errors[:base].first
    redirect "/picks/#{year}"
  end
  if !@user.save
    flash[:notice] = 'Username is taken.'
    redirect "/picks/#{year}"
  end
  redirect "/#{year}"
end
