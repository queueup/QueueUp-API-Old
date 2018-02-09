class AddingPostgresSerializerToLeagueProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :league_profiles, :temp_champions, :text, array: true, default: []
    add_column :league_profiles, :temp_goals, :text, array: true, default: []
    add_column :league_profiles, :temp_locales, :text, array: true, default: []
    add_column :league_profiles, :temp_roles, :text, array: true, default: []
    LeagueProfile.all.each do |l|
      l.update(
        temp_champions: YAML::load(l.champions).map(&:to_i),
        temp_goals: YAML::load(l.goals),
        temp_locales: YAML::load(l.locales),
        temp_roles: YAML::load(l.roles)
      )
    end
    remove_column :league_profiles, :champions
    remove_column :league_profiles, :goals
    remove_column :league_profiles, :locales
    remove_column :league_profiles, :roles
    rename_column :league_profiles, :temp_champions, :champions
    rename_column :league_profiles, :temp_goals, :goals
    rename_column :league_profiles, :temp_locales, :locales
    rename_column :league_profiles, :temp_roles, :roles
  end
end
