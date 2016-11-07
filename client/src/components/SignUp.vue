<template>
  <div class="signup">
    <h1> Signup </h1>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Email" v-model="email">
    </div>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Username" v-model="username">
    </div>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Firstname" v-model="firstname">
    </div>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Lastname" v-model="lastname">
    </div>
    <div class="form-group">
      <input type="password" class="form-control" placeholder="Password" v-model="password">
    </div>
    <div class="form-group">
      <input type="password" class="form-control" placeholder="Password Confirmation" v-model="password_confirmation">
    </div>
    <button type="button" @click="submit()"> SignUp! </button>
  </div>
</template>

<script>
  import auth from '../auth/auth'

  export default {
    data () {
      return {
        email: '',
        password: '',
        password_confirmation: '',
        username: '',
        firstname: '',
        lastname: ''
      }
    },
    methods: {
      submit () {
        auth.signup(this.email, this.password, this.password_confirmation, this.username, this.firstname, this.lastname)
      }
    }
  }
</script>
