<template>
  <div class="matches">
    <h1> Matches </h1>
    <div v-if="matches">
      <ul>
        <match v-for="match in matches" :match="match"></match>
      </ul>
    </div>
    <div v-else>
      No matches found.
    </div>
  </div>
</template>

<script>
  import Match from './Match.vue'
  import { getMatches } from '../../src/api'

  export default {
    components: {
      Match
    },
    data () {
      return {
        matches: []
      }
    },
    created () {
      getMatches().then(response => {
        this.matches = response.data
      })
    }
  }
</script>
