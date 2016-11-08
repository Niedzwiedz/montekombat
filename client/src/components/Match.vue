<template>
  <div>
    <p> {{ match.team_1.name }} ( {{ match.points_for_team1 }} ) vs. {{ match.team_2.name }} ( {{ match.points_for_team2 }} ) </p>
  </div>
</template>

<script>
  export default {
    props: {
      match_id: {
        type: Number,
        required: true
      }
    },
    computed: {
      match () {
        var index = this.$store.state.matches.findIndex(({ id }) =>
          id === this.match_id
        )
        return this.$store.state.matches[index]
      }
    }
  }
</script>
