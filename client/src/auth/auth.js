// import {router} from './../main.js'
/* global localStorage */
import axios from 'axios'

const LOGIN_PATH = 'http://localhost:3000/user_token'
// const SIGNUP_PATH = 'http://localhost:3000/users'

export default {
  user: {
    authenticated: false
  },

  login (email, password) {
    axios.post(LOGIN_PATH, {auth: {email: email, password: password}}).then(response => {
      localStorage.setItem('id_token', response.data.jwt)
      this.user.authenticated = true
    })
  },

  logout () {
    localStorage.removeItem('id_token')
    this.user.authenticated = false
  },
  checkAuth () {
    var jwt = localStorage.getItem('id_token')
    if (jwt) { this.user.authenticated = true } else { this.user.authenticated = false }
  },
  getAuthHeader () {
    return {
      'Authorization': 'Bearer ' + localStorage.getItem('id_token')
    }
  }
}
