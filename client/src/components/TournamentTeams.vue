<template>
  <div class="teams-list">
    <div class="form-group">
      <input placeholder="Add team name" v-model="newTeam" v-on:keyup.enter="addTeam">
    </div>
    <div class="form-group">
      <select v-model="selected_user">
        <option v-for="user in users" v-bind:value="user.id"> {{ user.username }} </option>
      </select>
    </div>
    <ul v-for="(team, team_index) in teams" :team="team">
      <li> {{ team.name }}
        <button v-on:click="removeTeam(team_index)"> X </button>
        <button v-on:click="addUser(team_index)"> + </button>
        <ul v-for="(user, user_index) in team.users">
          <li>
            {{ user.username }}
            <button v-on:click="removeUser(team_index, user_index)"> X </button>
          </li>
        </ul>
      </li>
    </ul>
  </div>
</template>

<script>
  import { postNewTeam, deleteTeam, deleteUserFromTeam, addUser } from '../api'
  export default {
    props: {
      teams: {}
    },
    data () {
      return {
        newTeam: '',
        selected_user: 1,
        users: this.$store.state.users
      }
    },
    methods: {
      addTeam () {
        var tournamentId = this.$route.params.id
        var team = { name: this.newTeam, tournament_id: tournamentId }
        var user = this.selected_user
        console.log(user)
        var that = this
        postNewTeam(team, user).then(function (response) {
          that.teams.push(response.data)
        })
      },
      removeTeam (index) {
        deleteTeam(this.teams[index].id)
        this.teams.splice(index, 1)
      },
      removeUser (parentIndex, index) {
        var teamId = this.teams[parentIndex].id
        var userId = this.teams[parentIndex].users[index].id
        deleteUserFromTeam(teamId, userId)
        this.teams[parentIndex].users.splice(index, 1)
        if (this.teams[parentIndex].users.length < 1 || this.teams[parentIndex].users === undefined) {
          this.teams.splice(parentIndex, 1)
        }
      },
      addUser (index) {
        var id = this.selected_user
        var user = this.users.filter(function (obj) {
          return obj.id === id
        })
        addUser(this.teams[index].id, id)
        this.teams[index].users.push({ username: user[0].username, id: id })
      }
    }
  }
</script>

<style>
  .teams-list {
    width: 40%;
    margin-left: 30%;
    margin-right: 30%;
    text-align: left;
  }
</style>
