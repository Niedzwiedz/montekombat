# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

reload = User.create(username: "reload", email: "re@load.com", firstname: "re", lastname: "load")
load = User.create(username: "load", email: "load@metallica.com", firstname: "load", lastname: "metallica")
ride_the_lightning = User.create(username: "ridethelightning", email: "ride@thelightning.com", firstname: "ride", lastname: "thelightning")
killem_all = User.create(username: "killemall", email: "kill@emall.com", firstname: "kill", lastname: "emall")
master_of_puppets = User.create(username: "masterofpuppets", email: "master@master.com", firstname: "master", lastname: "ofpupets")

metal = Team.create(name: "metal fans")
metallica = Team.create(name: "metallica fans")
music = Team.create(name: "music fans")
no = Team.create(name: "no fans")

metal.users << master_of_puppets
no.users << ride_the_lightning
metallica.users << load
music.users << killem_all

# TeamUser.create(team: metallica, user: killem_all)
# TeamUser.create(team: metallica, user: master_of_puppets)
# TeamUser.create(team: metallica, user: ride_the_lightning)

# TeamUser.create(team: metal, user: master_of_puppets)
# TeamUser.create(team: metal, user: killem_all)

# TeamUser.create(team: music, user: killem_all)
# TeamUser.create(team: music, user: master_of_puppets)

# TeamUser.create(team: no, user: reload)
# TeamUser.create(team: no, user: load)


mkx = Game.create(name: "Mortal Kombat X")
fifa = Game.create(name: "Fifa 2016")

Match.create(game: mkx, team_1: metal, team_2: no)
