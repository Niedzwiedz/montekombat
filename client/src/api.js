import axios from 'axios'
import Auth from './auth/auth'
import { router } from './main.js'
const API_PATH = 'http://localhost:3000/api/v1'
const LOGIN_PATH = 'http://localhost:3000/user_token'
export const getMatches = () => axios.get(API_PATH + '/matches.json')
export const postLogin = (email, password) => axios.post(LOGIN_PATH, {auth: {email: email, password: password}})

// kinda works, needs more work
axios.interceptors.response.use(function (response) {
  return response
}, function (error) {
  console.log(error)
  Auth.logout()
  router.push({name: 'login'})
})
export default {
  createHeader () {
    axios.defaults.headers.common['Authorization'] = Auth.getAuthHeader()
  },
  deleteHeader () {
    axios.defaults.headers.common['Authorization'] = ''
  }
}
