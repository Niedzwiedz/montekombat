<template>
  <div class="tournament-container">
    <div class="tournament-headers">
      <div class="tournament-header">
        <h3 class="tournament-title-header"> {{ tournament.title }} </h3>
        <h3 class="tournament-game-header"> {{ tournament.game.name }} </h3>
      </div>
      <div class="tournament-limit">
        <p> limit </p>
        <p> {{ tournament.number_of_teams }} </p>
      </div>
      <div class="tournament-status">
        <p> status </p>
        <p> {{ tournament.status }} </p>
      </div>
      <div class="tournament-creator">
        <p> created by </p>
        <p> {{ tournament.creator.firstname }} {{ tournament.creator.lastname }} </p>
      </div>
      <div class="tournament-date">
        <p> on </p>
        <p> {{ tournament.start_date }} </p>
      </div>
    </div>
    <div>
      <router-link :to="{ name: 'tournamentTeams', params: { id: $route.params.id } }"> Teams </router-link>
      <router-link :to="{ name: 'tournamentRounds', params: { id: $route.params.id } }"> Rounds </router-link>
      <router-view :rounds='tournament.rounds' :teams='tournament.teams'></router-view>
    <div>
  </div>
</template>

<script>
  import { getTournament } from '../api'

  export default {
    data () {
      return {
        tournament: {
          game: Object,
          creator: Object
        }
      }
    },
    created () {
      getTournament(this.$route.params.id).then(response => {
        this.tournament = response.data
      })
    }
  }
</script>

<style>
  .tournament-date {
    float: right;
  }
  .tournament-creator {
    float: left;
  }
  .tournament-limit {
    padding-left: 60px;
    padding-right: 20px;
    float: left;
  }
  .tournament-status {
    padding-right: 60px;
    padding-left: 10px;
    float: left;
  }
  .tournament-headers {
    display: inline-block;
  }
  .tournament-header {
    padding-right: 100px;
    float: left;
  }
  .tournament-container {
    width: 80%;
    margin-left: 10%;
    margin-right: 10%;
  }
  .tournament-game-header {
    margin-top: -20px;
    font-weight: 100;
  }
</style>
