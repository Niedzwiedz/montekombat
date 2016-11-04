<template>
  <div>
    <div> Round {{ round.round_number }} : </div>
    <table>
      <tr>
        <th> First Team </th>
        <th> Second Team </th>
        <th> Status </th>
        <th> Actions </th>
        <th> Winner </th>
      </tr>
      <tournamentMatch v-for="match in round.matches" :match_id='match.id' :round_id='round.id'></tournamentMatch>
    </table>
  </div>
</template>

<script>
  import TournamentMatch from './TournamentMatch'
  export default {
    components: {
      TournamentMatch
    },
    props: {
      round_id: Number
    },
    computed: {
      tournament () {
        return this.$store.state.tournaments[this.$store.state.tournaments.findIndex(({ id }) => id === this.$route.params.id)]
      },
      round () {
        return this.tournament.rounds[this.tournament.rounds.findIndex(({ id }) => id === this.round_id)]
      }
    }
  }
</script>

<style scoped>
  table {
    width: 60%;
    margin-left: 20%;
    margin-right: 20%;
  }
</style>
