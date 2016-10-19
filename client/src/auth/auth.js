// import {router} from './../main.js'
import axios from 'axios'
import myApi from '../api'

const LOGIN_PATH = 'http://localhost:3000/user_token'
// const SIGNUP_PATH = 'http://localhost:3000/users'

export default {
  user: {
    username: '',
    authenticated: false
  },

  login (email, password) {
    axios.post(LOGIN_PATH, {auth: {email: email, password: password}}).then(response => {
      localStorage.setItem('id_token', response.data.user_token.jwt)
      myApi.createHeader()
      this.user.authenticated = true
      this.user.username = response.data.user.username
    })
  },

  logout () {
    localStorage.removeItem('id_token')
    myApi.deleteHeader()
    this.user.authenticated = false
    this.user.username = ''
  },
  checkAuth () {
    var jwt = localStorage.getItem('id_token')
    this.user.authenticated = !!jwt
  },
  getAuthHeader () {
    return {
      'Authorization': 'Bearer ' + localStorage.getItem('id_token')
    }
  }
}
