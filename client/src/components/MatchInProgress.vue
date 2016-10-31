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
        return this.$store.state.tournaments[this.$store.state.tournaments.findIndex(({ id }) => id === this.$route.params.id)]
      },
      match () {
        return this.$store.state.matches[this.$store.state.matches.findIndex(({ id }) => id === this.$route.params.match_id)]
      }
    },
    methods: {
      endMatch () {
        this.match.status = 'finished'
        this.$store.dispatch('finishThisMatch', { points1: this.match.points_for_team1, points2: this.match.points_for_team2, matchId: this.$route.params.match_id })
        router.push({ name: 'tournamentRounds', params: { id: this.$route.params.id } })
      }
    }
  }
</script>

<style>
</style>
