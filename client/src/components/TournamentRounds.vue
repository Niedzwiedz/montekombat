<template>
  <div>
    <tournamentRound v-if="rounds.length > 0" v-for="round in rounds" :round_id='round.id'></tournamentRound>
    <div v-else>
      <h3> Rounds not generated yet </h3>
    </div>
    <router-view></router-view>
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
