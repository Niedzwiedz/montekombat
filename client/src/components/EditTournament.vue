<template>
  <div>
    <h2> Edit Tournament </h2>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Tournament Title" v-model="tournament.title">
    </div>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Tournament Description" v-model="tournament.description">
    </div>
    <div class="form-group">
      <input type="number" v-model="tournament.number_of_teams" min="1">
    </div>
    <div class="form-group">
      <input type="number" v-model="tournament.number_of_players_in_team" min="1">
    </div>
    <button v-on:click="editTournament()"> Edit Tournament </button>
  </div>
</template>

<script>
  export default {
    // props: {
    //   tournament: {}
    // },
    computed: {
      tournament () {
        return this.$store.state.tournaments[this.$store.state.tournaments.findIndex(({ id }) => id === this.$route.params.id)]
      }
    },
    methods: {
      editTournament () {
        // send tournament id and all the params
        var tournament = {
          title: this.tournament.title,
          description: this.tournament.description,
          number_of_teams: this.tournament.number_of_teams,
          number_of_players_in_team: this.tournament.number_of_players_in_teams,
          creator_id: this.tournament.creator_id
        }
        this.$store.dispatch('editOneTournament', { id: this.$route.params.id, tournament: tournament })
      }
    }
  }
</script>
