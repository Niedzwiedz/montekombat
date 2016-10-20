import axios from 'axios'
import Auth from './auth/auth'
import { router } from './main.js'

const API_PATH = 'http://localhost:3000/api/v1'
const LOGIN_PATH = 'http://localhost:3000/user_token'
// const SIGNUP_PATH = 'http://localhost:3000/users'
export const getMatches = () => axios.get(API_PATH + '/matches.json')
export const postLogin = (email, password) => axios.post(LOGIN_PATH, {auth: {email: email, password: password}})

axios.interceptors.response.use(function (response) {
  return response
}, function (error) {
  // add more status codes handling if needed
  if (error.response.status === 401 || error.response.status === 403) {
    Auth.logout()
    router.push({name: 'login'})
  } else if (error.response.status === 404) {
    router.push({name: 'error'})
  } else {
    router.push({name: 'error'})
  }
})
export default {
  createHeader () {
    axios.defaults.headers.common['Authorization'] = Auth.getAuthHeader()
  },
  deleteHeader () {
    axios.defaults.headers.common['Authorization'] = ''
  }
}
