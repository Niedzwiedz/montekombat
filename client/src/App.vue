<template>
  <div id="app">
    <img src="./assets/logo.png">
    <p v-if="user.authenticated"> {{ user.username }} </p>
    <navigation></navigation>
    <router-view></router-view>
  </div>
</template>

<script>
import Navigation from './components/Nav'
import auth from './auth/auth'

export default {
  name: 'app',
  data () {
    return {
      user: auth.user
    }
  },
  components: {
    Navigation
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
