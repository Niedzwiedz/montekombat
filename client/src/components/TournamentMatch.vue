<template>
  <tr>
    <td> {{ match.team_1.name }} - {{ match.points_for_team1 }} </td>
    <td> {{ match.team_2.name }} - {{ match.points_for_team2 }} </td>
    <td> {{ match.status }} </td>
    <td>
        <button v-if="match.status == 'upcoming'" @click="startMatch()"> start </button>
        <button v-if="match.status == 'in_progress'" @click="editScores()"> edit scores </button>
    </td>
  </tr>
</template>

<script>
  import { router } from '../main'
  export default {
    props: {
      match_id: Number
    },
    computed: {
      match () {
        return this.$store.state.matches[this.$store.state.matches.findIndex(({ id }) => id === this.match_id)]
      }
    },
    methods: {
      startMatch () {
        this.match.status = 'in_progress'
        this.$store.dispatch('startThisMatch', this.match_id)
        router.push({ name: 'matchPoints', params: { id: this.$route.params.id, match_id: this.match_id } })
      },
      editScores () {
        router.push({ name: 'matchPoints', params: { id: this.$route.params.id, match_id: this.match_id } })
      }
    }
  }
</script>
