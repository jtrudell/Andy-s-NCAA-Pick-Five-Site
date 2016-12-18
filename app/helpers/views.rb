helpers do
  # 2015 was first year; no 'previous_season/_year" for 2015
  def display_user(user)
    if @year == 2015
      "#{user.name} | #{user.wins(@year) || 0} wins"
    else
      "#{user.name} (#{@year - 1} total: #{Pick.previous_season_total_wins(user.teams, @year)})"
    end
  end

  def display_team(user, team)
    if @year == 2015
      "#{user.teams.index(team) + 1}. #{team.name} | 2015/2016 Wins: #{team.wins}"
    else
      "#{user.teams.index(team) + 1}. #{team.name} | Wins:\
        #{@current_year_teams.find_or_create_by(name: team.name, year: @year).wins}\
        (Last Year: #{@previous_year_teams.find_or_create_by(name: team.name, year: @year - 1).wins})"
    end
  end

  def display_standings(user)
    "#{@standings.index(user) + 1}. #{user.name} (wins: #{user.wins(@year)})"
  end
end
