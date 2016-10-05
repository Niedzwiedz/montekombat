# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
Team.delete_all
TeamUser.delete_all
Match.delete_all
Game.delete_all
Tournament.delete_all

load = User.create(username: "load", email: "load@metallica.com", firstname: "load", lastname: "metallica", password: "asd")
reload = User.create(username: "reload", email: "re@load.com", firstname: "re", lastname: "load", password: "load")
killem_all = User.create(username: "killemall", email: "kill@emall.com", firstname: "kill", lastname: "emall", password: "killem all")
master_of_puppets = User.create(username: "masterofpuppets", email: "master@master.com", firstname: "master", lastname: "ofpupets", password: "master of puppets")
ride_the_lightning = User.create(username: "ridethelightning", email: "ride@thelightning.com", firstname: "ride", lastname: "thelightning", password: "ride the lightning")

mkx = Game.create(name: "Mortal Kombat X")
fifa = Game.create(name: "Fifa 2016")

best_tournament = Tournament.create(game: mkx, creator: reload, title: "BestTournamentEva.", number_of_teams: 6, start_date: Time.now + 2.days, number_of_players_in_team: 6)

no = Team.create(name: "no fans", users: [load], tournament: best_tournament)
metal = Team.create(name: "metal fans", users: [master_of_puppets], tournament: best_tournament)
music = Team.create(name: "music fans", users: [ride_the_lightning], tournament: best_tournament)
metallica = Team.create(name: "metallica fans", users: [killem_all, master_of_puppets], tournament: best_tournament)

Match.create(game: mkx, team_1: metal, team_2: music)
Match.create(game: fifa, team_1: metallica, team_2: music)
