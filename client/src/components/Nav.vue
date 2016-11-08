<template>
<div>
  <router-link v-if="user.authenticated" :to="{name: 'tournaments'}">Tournaments</router-link>
  <router-link v-if="user.authenticated" :to="{name: 'matches'}">Matches</router-link>
  <router-link v-if="!user.authenticated" :to="{name: 'login'}">Login</router-link>
  <router-link v-if="!user.authenticated" :to="{name: 'signup'}">Sign Up</router-link>
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
