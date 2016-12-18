get '/' do
  redirect '/2016'
end

# Scraping NCAA site, so only update wins for current year
before '/2016' do
  Team.where(year: 2016).update_wins(2016)
end

get '/:year' do
  @year = params[:year].to_i
  @users = User.users_for(year: @year)
  @standings = User.standings(@year)
  @current_year_teams = Team.teams_for(year: @year)
  @previous_year_teams = Team.teams_for(year: @year - 1)
  erb :"index"
end

get '/picks/:year' do
  redirect '/' # no picks for you until next year!
  year = params[:year].to_i
  @teams = Team.teams_for(year: year)
  @previous_year_teams = Team.teams_for(year: year - 1)
  erb :"signup"
end

# TODO: refactor this next year; move logic to model, add helpers to view
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
  @picks = Pick.generate(@user, teams, year)
  if @user.errors[:base].any?
    flash[:notice] = @user.errors[:base].first
    redirect "/picks/#{year}"
  end
  if !@user.save
    flash[:notice] = 'Username is taken.'
    redirect "/picks/#{year}"
  end
  redirect "/#{year}"
end
