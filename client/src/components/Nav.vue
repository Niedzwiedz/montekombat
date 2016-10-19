<template>
<div>
  <router-link to="/home">Go to Home</router-link>
  <router-link to="/matches">View Matches</router-link>
  <router-link v-if="!user.authenticated" to="/login">Login</router-link>
  <a v-if="user.authenticated" @click="logout()"> Logout </a>
</div>
</template>

<script>
import auth from '../auth/auth'
export default {
  data () {
    return {
      user: auth.user
    }
  },
  methods: {
    logout () {
      auth.logout()
    }
  }
}
</script>

<style>
</style>
