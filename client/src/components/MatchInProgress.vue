<template>
  <div>
    <h2> {{ tournament.title }} </h2>
    <h3> {{ match.team_1.name }} vs. {{ match.team_2.name }} </h3>
    <div> {{ match.points_for_team1 }} : {{ match.points_for_team2 }} </div>
    <div> {{ match.team_1.name }} : </div>
    <div class="form-group">
      <input class="form-control" placeholder="Points for First Team" v-model="match.points_for_team1">
    </div>
    <div> {{ match.team_2.name }} : </div>
    <div class="form-group">
      <input class="form-control" placeholder="Points for First Team" v-model="match.points_for_team2">
    </div>
    <button @click="endMatch()"> Finish Match </button>
  </div>
</template>

<script>
  import { router } from '../main'
  export default {
    computed: {
      tournament () {
        return this.$store.getters.currentTournament
      },
      match () {
        return this.$store.getters.currentMatch
      },
      round () {
        return this.$store.getters.currentRound
      }
    },
    methods: {
      endMatch () {
        this.$store.dispatch('finishThisMatch', { points1: this.match.points_for_team1, points2: this.match.points_for_team2, matchId: this.$route.params.match_id, tournamentId: this.tournament.id })
        router.push({ name: 'tournamentRounds', params: { id: this.$route.params.id } })
      }
    }
  }
</script>

<style>
</style>
