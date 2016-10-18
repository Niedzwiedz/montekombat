/* global localStorage */
import axios from 'axios'
// import auth from './auth/auth'

// axios.defaults.headers.common['Authorization'] = auth.getAuthHeader()

const API_PATH = 'http://localhost:3000/api/v1'

// header setted manualy for now, just to see how it works, and it works!
export const getMatches = () => axios.get(API_PATH + '/matches.json', {headers: {'Authorization': 'Bearer ' + localStorage.getItem('id_token')}})
