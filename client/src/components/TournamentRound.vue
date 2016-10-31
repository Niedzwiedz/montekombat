<template>
  <div>
    <div> Round {{ round.round_number }} : </div>
    <table>
      <tr>
        <th> First Team </th>
        <th> Second Team </th>
        <th> Status </th>
        <th> Actions </th>
      </tr>
      <tournamentMatch v-for="match in round.matches" :match_id='match.id'></tournamentMatch>
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
      round: {}
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
