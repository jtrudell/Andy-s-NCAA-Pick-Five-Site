# frozen_string_literal: true

require 'pry'

def current_year
  return @current_year if defined?(@current_year)
  today = Time.now
  year_end = Time.new(2017, 12, 31)
  season_end = Time.new(2018, 4, 30)
  @current_year = if today > year_end && today < season_end
                    Time.now.year - 1
                  else
                    Time.now.year
                  end
end

before '/:year' do
  year = params[:year].to_i
  @teams ||= Team.where(year: year)
  @teams.update_wins(year) if Time.now > Time.new(2017, 11, 10)
end

get '/' do
  redirect "/#{current_year}"
end

get '/:year' do
  @year = params[:year].to_i
  @users ||= User.users_for(year: @year)
  @standings ||= User.standings(@year)
  @current_year_teams ||= Team.teams_for(year: current_year)
  @previous_year_teams ||= Team.teams_for(year: current_year - 1)
  erb :index
end

get '/picks/:year' do
  year = params[:year].to_i
  redirect '/' if year > current_year
  @teams ||= Team.teams_for(year: year)
  @previous_year_teams ||= Team.teams_for(year: year - 1)
  erb :signup
end

post '/picks/:year' do
  year = params[:year].to_i
  tie_breaker = params[:tie_breaker].to_i
  @user ||= User.new(name: params['name'].titleize, tie_breaker: tie_breaker, year: year)
  teams = [
    params['pickone'],
    params['picktwo'],
    params['pickthree'],
    params['pickfour'],
    params['pickfive']
  ]
  teams.reject!(&:empty?)
  @picks ||= Pick.generate(@user, teams, year)

  if teams.count != 5
    flash[:notice] = "You selected #{teams.count} teams. You must pick 5 teams."
  elsif @user.errors[:base].any?
    flash[:notice] = @user.errors[:base].first
  elsif !@user.save
    flash[:notice] = 'Username is taken.'
  else
    redirect "/#{year}"
  end
  redirect "/picks/#{year}"
end
