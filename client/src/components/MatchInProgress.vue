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
        var index = this.$store.state.tournaments.findIndex(({ id }) =>
          id === this.$route.params.id
        )
        return this.$store.state.tournaments[index]
      },
      match () {
        var index = this.$store.state.matches.findIndex(({ id }) =>
          id === this.$route.params.match_id
        )
        return this.$store.state.matches[index]
      },
      round () {
        var index = this.$store.state.rounds.findIndex(({ id }) =>
          id === this.$route.params.round_id
        )
        return this.tournament.rounds[index]
      }
    },
    methods: {
      endMatch () {
        this.match.status = 'finished'
        this.$store.dispatch('finishThisMatch', { points1: this.match.points_for_team1, points2: this.match.points_for_team2, matchId: this.$route.params.match_id })
        if (this.match.points_for_team1 > this.match.points_for_team2) {
          this.match.winner = this.match.team_1
        } else {
          this.match.winner = this.match.team_2
        }
        if (this.round.matches.find(({ status }) => status === 'upcoming' || status === 'in_progress') === undefined) {
          this.$store.dispatch('getOneTournament', this.$route.params.id)
        }
        router.push({ name: 'tournamentRounds', params: { id: this.$route.params.id } })
      }
    }
  }
</script>

<style>
</style>
