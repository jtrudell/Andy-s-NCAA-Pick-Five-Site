helpers do
  def display_user(user, year)
    "#{user.name} (#{year - 1} total: #{Pick.previous_season_total_wins(user.teams, year)})"
  end
end
