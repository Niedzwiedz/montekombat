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
Team.create(name: "polish reaggae fans")
no = Team.create(name: "no fans")

TeamUser.create(metallica, killem_all)
TeamUser.create(metallica, master_of_puppets)
TeamUser.create(metallica, ride_the_lightning)

TeamUser.create(metal, master_of_puppets)
TeamUser.create(metal, killem_all)

TeamUser.create(music, killem_all)
TeamUser.create(music, master_of_puppets)

TeamUser.create(no, reload)
TeamUser.create(no, load)

mkx = Game.create(name: "Mortal Kombat X")
fifa = Game.create(name: "Fifa 2016")

Match.create(mkx, metal, no)
Match.create(fifa, metallica, no)
