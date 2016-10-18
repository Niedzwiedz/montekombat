import axios from 'axios'
import auth from './auth/auth'

axios.defaults.headers.common['Authorization'] = auth.getAuthHeader()

const API_PATH = 'http://localhost:3000/api/v1'
export const getMatches = () => axios.get(API_PATH + '/matches.json')
