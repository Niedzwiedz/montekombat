<template>
  <tr>
    <td class="tournament-title"> <router-link class="tournament-link-style" :to="{ name: 'tournamentTeams', params: { id: tournament.id } }" > {{ tournament.title }} </router-link> </td>
    <td> {{ tournament.game.name }} </td>
    <td class="not-important"> {{ tournament.creator.firstname }} {{ tournament.creator.lastname }} </td>
    <td> {{ tournament.number_of_teams }} </td>
    <td class="not-important"> {{ tournament.status }} </td>
  </tr>
</template>

<script>
  export default {
    props: {
      tournament: {
        type: Object
      }
    }
  }
</script>

<style>
  .tournament-title {
    font-weight: bold;
  }
  .tournament-link-style {
    text-decoration: none;
    color: black;
  }
  .not-important {
    color: gray;
  }
  td {
    padding: 30px 30px 30px 0px;
    text-align: left;
  }
</style>
