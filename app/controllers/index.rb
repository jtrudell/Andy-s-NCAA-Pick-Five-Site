# frozen_string_literal: true

require 'pry'

def current_year
  @current_year if defined?(@current_year)
  today = Time.now
  year_end = Time.new(2017, 12, 31)
  season_end = Time.new(2018, 4, 30)
  @current_year = if today > year_end && today < season_end
                    Time.now.year - 1
                  else
                    Time.now.year
                  end
end

def last_year
  @last_year ||= current_year - 1
end

before "/#{current_year}" do
  @teams ||= Team.where(year: current_year)
  @teams.update_wins(current_year) if Time.now > Time.new(2017, 11, 10)
end

get '/' do
  redirect "/#{current_year}"
end

get '/:year' do
  @year = params[:year].to_i
  @users = User.users_for(year: @year)
  @standings = User.standings(@year)
  @current_year_teams = Team.teams_for(year: current_year)
  @previous_year_teams = Team.teams_for(year: last_year)
  erb :index
end

get '/picks/:year' do
  # redirect '/' # no picks for you until next year!
  year = params[:year].to_i
  @teams = Team.teams_for(year: year)
  @previous_year_teams = Team.teams_for(year: last_year)
  erb :signup
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
  teams.reject! { |team| team == '' }
  if teams.count != 5
    flash[:notice] = "You selected #{teams.count} teams. You must pick 5 teams."
    redirect "/picks/#{year}"
  end
  @picks = Pick.generate(@user, teams, year)
  if @user.errors[:base].any?
    flash[:notice] = @user.errors[:base].first
    redirect "/picks/#{year}"
  end
  unless @user.save
    flash[:notice] = 'Username is taken.'
    redirect "/picks/#{year}"
  end
  redirect "/#{year}"
end
