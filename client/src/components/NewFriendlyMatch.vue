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
      <input placeholder="First team name" v-model="team1_name">
    </div>
    <ul>
      <li v-for="(userInTeam1, user1Index) in team1_users">
        <span> {{ userInTeam1.username }} </span>
      </li>
    </ul>
    <div>
      <button v-on:click="addUserToTeam1()"> Add User </button>
    </div>
    <p> second team: </p>
    <div class="form-group">
      <input placeholder="Second team name" v-model="team2_name">
    </div>
    <ul>
      <li v-for="(userInTeam2, user2Index) in team2_users">
        <span> {{ userInTeam2.username }} </span>
      </li>
    </ul>
    <div class="form-group">
      <button v-on:click="addUserToTeam2()"> Add User </button>
    </div>
    <button v-on:click="sendMatch()"> Create Match</button>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        newTeam: '',
        team1_name: '',
        team2_name: '',
        team1_users: [],
        team2_users: [],
        selected_user: 1,
        users: this.$store.state.users,
        selected_game: 1,
        games: this.$store.state.games
      }
    },
    methods: {
      addUserToTeam1 () {
        var id = this.selected_user
        var user = this.users.filter(function (obj) {
          return obj.id === id
        })
        if (id) {
          this.team1_users.push({ username: user[0].username, id: id })
        }
      },
      addUserToTeam2 () {
        var id = this.selected_user
        var user = this.users.filter(function (obj) {
          return obj.id === id
        })
        if (id) {
          this.team2_users.push({ username: user[0].username, id: id })
        }
      },
      removeUserFromTeam1 (index) {
        this.team1_users.splice(index, 1)
      },
      sendMatch () {
      }
    }
  }
</script>
