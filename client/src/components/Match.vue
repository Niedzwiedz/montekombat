<template>
  <div>
    <p> {{ match.team_1.name }} ( {{ match.points_for_team1 }} ) vs. {{ match.team_2.name }} ( {{ match.points_for_team2 }} ) </p>
  </div>
</template>

<script>
  export default {
    props: {
      match: {
        type: Object
      }
    },
    methods: {}
  }
</script>
