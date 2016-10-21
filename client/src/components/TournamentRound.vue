<template>
  <div>
    <div> Round {{ round.round_number }} : </div>
    <tournamentMatch v-for="match in round.matches" :match='match'></tournamentMatch>
  </div>
</template>

<script>
  import TournamentMatch from './TournamentMatch'
  export default {
    components: {
      TournamentMatch
    },
    props: {
      round: {}
    }
  }
</script>
