# frozen_string_literal: true

helpers do
  def wins(user, year = Time.now.year)
    user.wins(year).to_s
  end

  # 2015 was first year; no 'previous_season/_year" for 2015
  def display_user(user)
    if @year == 2015
      "#{user.name} | #{wins(user) || 0} wins"
    else
      "#{user.name} (#{current_year - 1} total: #{Pick.previous_season_total_wins(user.teams, @year)})"
    end
  end

  def display_team(_user, team, index)
    if @year == 2015
      "#{index + 1}. #{team.name} | 2015/2016 Wins: #{team.wins}"
    else
      "#{index + 1}. #{team.name} | Wins:\
        #{@current_year_teams.find_or_create_by(name: team.name, year: @year).wins}\
        (Last Year: #{@previous_year_teams.find_or_create_by(name: team.name, year: current_year - 1).wins})"
    end
  end

  def display_standings(user, index)
    "#{index + 1}. #{user.name} (wins: #{wins(user)})"
  end
end
