<template>
<div>
  <router-link v-if="user.authenticated" to="/tournaments">Tournaments</router-link>
  <router-link v-if="user.authenticated" to="/matches">Matches</router-link>
  <router-link v-if="!user.authenticated" to="/login">Login</router-link>
  <router-link v-if="!user.authenticated" to="/signup">Sign Up</router-link>
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
