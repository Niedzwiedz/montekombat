<template>
  <div>
    <tournamentRound v-for="round in rounds" :round='round'></tournamentRound>
  </div>
</template>

<script>
  import TournamentRound from './TournamentRound'
  export default {
    components: {
      TournamentRound
    },
    props: {
      rounds: {}
    }
  }
</script>
