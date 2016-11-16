// import {router} from './../main.js'
import api, { postLogin, postSignUp } from '../api'
import { router } from '../main'

export default {
  user: {
    id: '',
    username: '',
    authenticated: false
  },
  login (email, password) {
    postLogin(email, password).then(response => {
      localStorage.setItem('id_token', response.data.user_token.jwt)
      api.createHeader()
      this.user.authenticated = true
      this.user.username = response.data.user.username
      this.user.id = response.data.user.id
      router.push({name: 'tournaments'})
    })
  },
  logout () {
    localStorage.removeItem('id_token')
    api.deleteHeader()
    this.user.authenticated = false
    this.user.username = ''
    this.user.id = ''
    router.push({name: 'login'})
  },
  signup (email, password, passwordConfirmation, username, firstname, lastname) {
    postSignUp(email, password, passwordConfirmation, username, firstname, lastname).then(response => {
      this.login(email, password)
    })
  },
  checkAuth () {
    var jwt = localStorage.getItem('id_token')
    this.user.authenticated = !!jwt
  },
  getAuthHeader () {
    return 'Bearer ' + localStorage.getItem('id_token')
  }
}
