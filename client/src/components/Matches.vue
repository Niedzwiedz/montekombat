<template>
  <div class="matches">
    <h1> Matches </h1>
    <div v-if="matches.length > 0">
      <ul>
        <match v-for="match in matches" :match="match"></match>
      </ul>
    </div>
    <div v-else>
      No matches found.
    </div>
    <router-link :to="{ name: 'newFriendlyMatch' }"> Create Friendly Match </router-link>
    <router-view></router-view>
  </div>
</template>

<script>
  import Match from './Match.vue'

  export default {
    components: {
      Match
    },
    computed: {
      matches () {
        /* eslint-disable camelcase */
        return this.$store.state.matches.filter(({ match_type }) => match_type === 'friendly')
        /* eslint-enable camelcase */
      }
    }
  }
</script>
