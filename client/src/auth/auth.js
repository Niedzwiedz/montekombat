// import {router} from './../main.js'
import api, { postLogin } from '../api'

// const SIGNUP_PATH = 'http://localhost:3000/users'
export default {
  user: {
    username: '',
    authenticated: false
  },
  login (email, password) {
    postLogin(email, password).then(response => {
      localStorage.setItem('id_token', response.data.user_token.jwt)
      api.createHeader()
      this.user.authenticated = true
      this.user.username = response.data.user.username
    })
  },
  logout () {
    localStorage.removeItem('id_token')
    api.deleteHeader()
    this.user.authenticated = false
    this.user.username = ''
  },
  checkAuth () {
    var jwt = localStorage.getItem('id_token')
    this.user.authenticated = !!jwt
  },
  getAuthHeader () {
    return 'Bearer ' + localStorage.getItem('id_token')
  }
}
