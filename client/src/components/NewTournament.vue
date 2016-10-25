<template>
  <div>
    <h1> Create New Tournament </h1>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Tournament Title" v-model="tournament_title">
    </div>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Tournament Description" v-model="tournament_description">
    </div>
    <div class="form-group">
      <select v-model="selected_game">
        <option v-for="game in games" v-bind:value="game.id"> {{ game.name }} </option>
      </select>
    </div>
    <div class="form-group">
      <select v-model="selected_type">
        <option v-for="type in types" v-bind:value="type"> {{ type }} </option>
      </select>
    </div>
    <div class="form-group">
      <input type="number" v-model="number_of_teams" min="1">
    </div>
    <div class="form-group">
      <input type="number" v-model="number_of_players_in_team" min="1">
    </div>
    <div class="form-group">
      <input placeholder="Add proper datepicker!" type="datetime-local" v-model="start_date">
    </div>
    <h2> Teams: </h2>
    <input placeholder="Add team name" v-model="newTeam" v-on:keyup.enter="addTeam">
      <select v-model="selected_user">
        <option v-for="user in users" v-bind:value="user.id"> {{ user.username }} </option>
      </select>
    <ul>
      <li v-for="(team, team_index) in teams_display">
        <span> {{ team.name }} </span>
        <button v-on:click="removeTeam(team_index)"> X </button>
        <button v-on:click="addUser(team_index)"> + </button>
        <ul>
          <li v-for="(user, user_index) in team.users">
            <span> {{ user.username }} </span>
            <button v-on:click="removeUser(team_index, user_index)"> X </button>
          </li>
        </ul>
      </li>
    </ul>
    <button v-on:click="sendTournament()"> Create Tournament </button>
  </div>
</template>

<script>
  import { getGames, getTournamentTypes, getUsers } from '../api'
  import Auth from '../auth/auth'

  export default {
    data () {
      return {
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
        start_date: '',
        user: Auth.user
      }
    },
    created () {
      getGames().then(response => {
        this.games = response.data
      })
      getTournamentTypes().then(response => {
        this.types = response.data
      })
      getUsers().then(response => {
        this.users = response.data
      })
    },
    methods: {
      addTeam () {
        var text = this.newTeam.trim()
        if (text) {
          this.teams_display.push({name: text, users: []})
          this.teams.push({name: text, users: []})
          this.newTeam = ''
        }
      },
      addUser (index) {
        var id = this.selected_user
        var user = this.users.filter(function (obj) {
          return obj.id === id
        })
        if (id) {
          this.teams_display[index].users.push({ username: user[0].username, id: id })
          this.teams[index].users.push({ id: id })
        }
      },
      removeTeam (index) {
        this.teams.splice(index, 1)
        this.teams_display.splice(index, 1)
      },
      removeUser (parentIndex, index) {
        this.teams[parentIndex].users.splice(index, 1)
        this.teams_display[parentIndex].users.splice(index, 1)
      },
      sendTournament () {
        var tournament = {
          game_id: this.selected_game,
          title: this.tournament_title,
          description: this.tournament_description,
          tournament_type: this.selected_type,
          number_of_teams: this.number_of_teams,
          number_of_players_in_team: this.number_of_players_in_team,
          start_date: this.start_date,
          creator: this.user.id
        }
        var teamsArray = this.teams
        var teams = Object.assign({}, teamsArray)
        this.$store.dispatch('addNewTournament', { tournament: tournament, teams: teams })
      }
    }
  }
</script>
