import axios from 'axios'
import Auth from './auth/auth'
const API_PATH = 'http://localhost:3000/api/v1'
export const getMatches = () => axios.get(API_PATH + '/matches.json')
export default {
  createHeader () {
    axios.defaults.headers.common['Authorization'] = Auth.getAuthHeader()['Authorization']
  },
  deleteHeader () {
    axios.defaults.headers.common['Authorization'] = ''
  }
}
