import axios from 'axios'

const API_PATH = 'http://localhost:3000/api/v1'

export const getMatches = () => axios.get(API_PATH + '/matches.json')
