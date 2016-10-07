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
//= require jquery
//= require tether
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require vue
//= require vue-router
//= require vue-resource

var teams = new Vue({
    el: '#teams_form',
    data: {
        newTeam: '',
        teams: [
            { text: "dupa", users: [
                { text: "alexander" },
                { text: "wladyslaw" }
            ]
            }
        ]
    },
    methods: {
        addTeam: function () {
            var text = this.newTeam.trim();
            if (text) {
                this.teams.push({ text: text, users: []});
                this.newTeam = '';
            }
        },
        addUser: function (index) {
            var text = "sebastian";
            if (text) {
                this.teams[index].users.push({ text: text });
            }
        },
        removeTeam: function (index) {
            this.teams.splice(index, 1);
        }
    }
});
