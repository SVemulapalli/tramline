crumb :root do
  link "Home", root_path
end

crumb :team do
  link "Team", accounts_organization_team_path(current_organization.slug)
end

crumb :new_member do
  link "Add Member"
  parent :team
end

crumb :memberships do
  link "Memberships", root_path
end

# Issue list
crumb :apps do
  link "All apps", apps_path
end

crumb :app do |app|
  link app.name, app_path(app)
  parent :apps
end

crumb :new_app do
  link "New App"
  parent :apps
end

crumb :edit_app do |app|
  link "Edit"
  parent :app, app
end

crumb :train do |train|
  link train.name, app_train_path(train.app, train)
  parent :app, train.app
end

crumb :step do |step|
  link step.name
  parent :train, step.train
end

crumb :new_step do |train|
  link "New Step"
  parent :train, train
end

crumb :release do |release|
  link release.release_version, release_path(release)
  parent :train, release.train
end

crumb :timeline_release do |release|
  link "Release Activity", timeline_release_path(release)
  parent :release, release
end

crumb :app_config do |config|
  link "App config", edit_app_app_config_path(config.app, config)
  parent :app, config.app
end

crumb :all_builds do |app|
  link "All builds", all_builds_app_path(app)
  parent :app, app
end

crumb :integrations do |app|
  link "Integrations", app_integrations_path(app)
  parent :app, app
end

crumb :new_train do |app|
  link "New Train"
  parent :app, app
end

crumb :edit_train do |train|
  link "Edit"
  parent :train, train
end

crumb :edit_train_notification do |train|
  link "Edit Notification Settings"
  parent :train, train
end
