<template>
  <div>
    <table class="default-table">
      <tr>
        <th> name </th>
      </tr>
      <tournamentTeam v-for="team in teams" :team="team"></tournamentTeam>
    </table>
  </div>
</template>

<script>
  import TournamentTeam from './TournamentTeam'
  export default {
    components: {
      TournamentTeam
    },
    props: {
      teams: {}
    }
  }
</script>

<style>
</style>
