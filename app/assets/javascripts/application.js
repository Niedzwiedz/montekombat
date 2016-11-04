// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require tether
//= require bootstrap-sprockets
//= require_tree .


var tournaments = new Vue({
    el: '#tournament_form',
    data: {
        newTeam: '',
        newUser: '',
        selected_user: '',
        users: [],
        teams_display: [],
        teams: [],
        tournament_title: '',
        tournament_description: '',
        selected_game: '',
        games: [],
        selected_type: '',
        types: [],
        number_of_teams: 1,
        number_of_players_in_team: 1,
        start_date: ''
    },
    ready: function(){
        var that;
        that = this;
        $.ajax({
            url: '/users.json',
            success: function(response) {
                that.users = response;
            }
        }),
        $.ajax({
            url: '/games',
            success: function(response) {
                that.games = response;
            }
        }),
        $.ajax({
            url: '/tournaments/types.json',
            success: function(response) {
                that.types = response;
            }
        });
    },
    methods: {
        addTeam: function () {
            var text = this.newTeam.trim();
            if (text) {
                this.teams_display.push({ name: text, users: []});
                this.teams.push({ name: text, users: []});
                this.newTeam = '';
            }
        },
        addUser: function (index) {
            var id = this.selected_user;
            var user = this.users.filter(function(obj) {
                return obj.id == id;
            });

            if (id) {
                this.teams_display[index].users.push({ username: user[0].username, id: id });
                this.teams[index].users.push({ id: id });
            }
        },
        removeTeam: function (index) {
            this.teams.splice(index, 1);
            this.teams_display.splice(index, 1);
        },
        removeUser: function (parent_index, index) {
            this.teams[parent_index].users.splice( index, 1);
            this.teams_display[parent_index].users.splice( index, 1);
        },
        sendTournament: function () {
            var that = this;
            $.ajax({
                method: 'POST',
                data: {
                    tournament: {
                        game_id: that.selected_game.id,
                        title: that.tournament_title,
                        description: that.tournament_description,
                        tournament_type: that.selected_type,
                        number_of_teams: that.number_of_teams,
                        number_of_players_in_team: that.number_of_players_in_team,
                        start_date: that.start_date
                    },
                    teams: that.teams
                },
                url: '/tournaments.json'
            });
        }
    }
});
var tournament_edit = new Vue({
    el: '#tournament_edit_form',
    data: {
        newTeam: '',
        newUser: '',
        selected_user: 1,
        users: [],
        teams_display: [],
        teams: [],
        tournament_title: '',
        tournament_description: '',
        selected_game: '',
        games: [],
        selected_type: '',
        types: [],
        number_of_teams: 1,
        number_of_players_in_team: 1,
        start_date: ''
    },
    ready: function(tournament){
        var that;
        that = this;
        var id = document.getElementById("edit_tournament_header").getAttribute("data-id");
        $.ajax({
            url: '/users.json',
            success: function(res) {
                that.users = res;
            }
        }),
        $.ajax({
            url: '/games',
            success: function(response) {
                that.games = response;
            }
        }),
        $.ajax({
            url: '/tournaments/types.json',
            success: function(response) {
                that.types = response;
            }
        }),
        $.ajax({
            url: '/tournaments/'+ id + '.json',
            success: function(response) {
                that.tournament_title = response.title;
                that.tournament_description = response.description;
                that.selected_type = response.type;
                that.number_of_teams = response.number_of_teams;
                that.number_of_players_in_team = response.number_of_players_in_team;
                that.start_date = response.start_date;
                that.selected_game = response.game.id;
                that.teams_display = response.teams;
            }
        });
    },
    methods: {
        addTeam: function () {
            var that = this;
            var text = this.newTeam.trim();
            var id = document.getElementById("edit_tournament_header").getAttribute("data-id");
            $.ajax({
                method: 'POST',
                url: '/teams.json',
                data: {
                    team: {
                        name: text,
                        tournament_id: id
                    },
                    user: that.selected_user
                },
                success: function(response) {
                    alert(JSON.stringify(response));
                    that.teams_display.push({ id: response.id, name: response.name, users: response.users});
                    that.newTeam= '';
                }
            });
        },
        addUser: function (index) {
            var that = this;
            var id = this.selected_user;
            var user = this.users.filter(function(obj) {
                return obj.id == id;
            });

            $.ajax({
                method: 'POST',
                url: '/teams/' + that.teams_display[index].id + '/add_user/' + id,
                success: function(){
                    that.teams_display[index].users.push({ username: user[0].username, id: id });
                }
            });
        },
        removeTeam: function (index) {
            var that = this;
            $.ajax({
                method: 'DELETE',
                url: '/teams/' + that.teams_display[index].id,
                success: function(){
                    that.teams_display.splice(index, 1);
                }
            });
        },
        removeUser: function (parent_index, index) {
            var that = this;
            var team_id = this.teams_display[parent_index].id;
            var user_id = this.teams_display[parent_index].users[index].id;
            $.ajax({
                method: 'DELETE',
                url: '/teams/' + team_id + '/remove_user/' + user_id,
                success: function(){
                    that.teams_display[parent_index].users.splice( index, 1);
                    if(that.teams_display[parent_index].users.length < 1 || that.teams_display[parent_index].users == undefined){
                        that.teams_display.splice(parent_index, 1);
                    }
                }
            });
        },
        updateTournament: function () {
            var that = this;
            var id = document.getElementById("edit_tournament_header").getAttribute("data-id");
            $.ajax({
                method: 'PATCH',
                data: {
                    tournament: {
                        game_id: that.selected_game.id,
                        title: that.tournament_title,
                        description: that.tournament_description,
                        tournament_type: that.selected_type,
                        number_of_teams: that.number_of_teams,
                        number_of_players_in_team: that.number_of_players_in_team,
                        start_date: that.start_date
                    }
                },
                url: '/tournaments/' + id
            });
        }
    }
});
