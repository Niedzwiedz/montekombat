<template>
  <div class="tournaments">
    <h1> Tournaments </h1>
    <table class="default-table">
      <tr>
        <th class="table-header not-important"> name </th>
        <th class="table-header"> type </th>
        <th class="table-header not-important"> created by </th>
        <th class="table-header not-important"> teams </th>
        <th class="table-header not-important"> status </th>
      </tr>
      <tournament v-for="tournament in tournaments" :tournament="tournament"></tournament>
    </table>
  </div>
</template>

<script>
  import Tournament from './Tournament.vue'
  import { getTournaments } from '../../src/api'

  export default {
    components: {
      Tournament
    },
    data () {
      return {
        tournaments: []
      }
    },
    created () {
      getTournaments().then(response => {
        this.tournaments = response.data
      })
    }
  }
</script>

<style>
.default-table {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin-top: 60px;
  width:60%;
  margin-left:20%;
  margin-right:20%;
}
.table-header {
  font-wight: lighter;
  font-style: italic;
  font-size: 80%;
}
th {
  text-align: left;
}
</style>
