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

load = User.create(username: "load", email: "load@metallica.com", firstname: "load", lastname: "metallica")
reload = User.create(username: "reload", email: "re@load.com", firstname: "re", lastname: "load")
killem_all = User.create(username: "killemall", email: "kill@emall.com", firstname: "kill", lastname: "emall")
master_of_puppets = User.create(username: "masterofpuppets", email: "master@master.com", firstname: "master", lastname: "ofpupets")
ride_the_lightning = User.create(username: "ridethelightning", email: "ride@thelightning.com", firstname: "ride", lastname: "thelightning")

no = Team.create(name: "no fans", users: [load])
metal = Team.create(name: "metal fans", users: [master_of_puppets])
music = Team.create(name: "music fans", users: [ride_the_lightning])
metallica = Team.create(name: "metallica fans", users: [killem_all, master_of_puppets])

mkx = Game.create(name: "Mortal Kombat X")
fifa = Game.create(name: "Fifa 2016")

Match.create(game: mkx, team_1: metal, team_2: music)
Match.create(game: fifa, team_1: metallica, team_2: music)
