<template>
  <div>
    <h2> Create New Friendly Match </h2>
    <div class="form-group">
      game selection:
      <select v-model="selected_game">
        <option v-for="game in games" v-bind:value="game.id"> {{ game.name }} </option>
      </select>
    </div>
    <h3> Teams: </h3>
    <div class="form-group">
      user list:
      <select v-model="selected_user">
        <option v-for="user in users" v-bind:value="user.id"> {{ user.username }} </option>
      </select>
    </div>
    <p> first team: </p>
    <div class="form-group">
      <input placeholder="First team name" v-model="team1Name">
      <button v-on:click="addUserToTeam1()"> Add User </button>
    </div>
    <ul>
      <li v-for="(userInTeam1, user1Index) in team1Users">
        <span> {{ userInTeam1.username }} </span>
        <button v-on:click="removeUserFromTeam1(user1Index)"> X </button>
      </li>
    </ul>
    <p> second team: </p>
    <div class="form-group">
      <input placeholder="Second team name" v-model="team2Name">
      <button v-on:click="addUserToTeam2()"> Add User </button>
    </div>
    <ul>
      <li v-for="(userInTeam2, user2Index) in team2Users">
        <span> {{ userInTeam2.username }} </span>
        <button v-on:click="removeUserFromTeam2(user2Index)"> X </button>
      </li>
    </ul>
    <button v-on:click="sendMatch()"> Create Match</button>
  </div>
</template>

<script>
  import Auth from '../auth/auth'

  export default {
    data () {
      return {
        newTeam: '',
        team1Name: '',
        team2Name: '',
        team1Users: [],
        team2Users: [],
        selected_user: 1,
        users: this.$store.state.users,
        selected_game: 1,
        games: this.$store.state.games,
        user: Auth.user
      }
    },
    methods: {
      addUserToTeam1 () {
        var id = this.selected_user
        var user = this.users.filter(function (obj) {
          return obj.id === id
        })
        if (id) {
          this.team1Users.push({ username: user[0].username, id: id })
        }
      },
      addUserToTeam2 () {
        var id = this.selected_user
        var user = this.users.filter(function (obj) {
          return obj.id === id
        })
        if (id) {
          this.team2Users.push({ username: user[0].username, id: id })
        }
      },
      removeUserFromTeam1 (index) {
        this.team1Users.splice(index, 1)
      },
      removeUserFromTeam2 (index) {
        this.team2Users.splice(index, 1)
      },
      sendMatch () {
        var match = {
          game_id: this.selected_game,
          creator: this.user.id
        }
        var usersForTeam1 = Object.assign({}, this.team1Users)
        var team1 = {
          name: this.team1Name
        }
        var usersForTeam2 = Object.assign({}, this.team2Users)
        var team2 = {
          name: this.team2Name
        }
        this.$store.dispatch('addFriendlyMatch', { match: match, team1: team1, team2: team2, usersForTeam1: usersForTeam1, usersForTeam2: usersForTeam2 })
      }
    }
  }
</script>
