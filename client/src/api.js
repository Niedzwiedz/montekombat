import axios from 'axios'
import Auth from './auth/auth'
import { router } from './main.js'

const API_PATH = 'http://localhost:3000/api/v1'
const LOGIN_PATH = 'http://localhost:3000/user_token'
const SIGNUP_PATH = 'http://localhost:3000/api/v1/users'
export const getMatches = () => axios.get(API_PATH + '/matches.json')
export const getGames = () => axios.get(API_PATH + '/games.json')
export const getTournaments = () => axios.get(API_PATH + '/tournaments.json')
export const getTournament = id => axios.get(API_PATH + '/tournaments/' + id + '.json')
export const getUsers = () => axios.get(API_PATH + '/users.json')
export const getTournamentTypes = () => axios.get(API_PATH + '/tournaments/types.json')
export const postLogin = (email, password) => axios.post(LOGIN_PATH, {auth: {email: email, password: password}})
export const postSignUp = (email, password, passwordConfirmation, username, firstname, lastname) => axios.post(SIGNUP_PATH, {user: {email: email, password: password, password_confirmation: passwordConfirmation, username: username, firstname: firstname, lastname: lastname}})
export const postNewTournament = (tournament, teams) => axios.post(API_PATH + '/tournaments.json', { tournament: tournament, teams: teams })
export const postNewTeam = (team, user) => axios.post(API_PATH + '/teams.json', { team: team, user: user })
export const deleteTeam = (teamId) => axios.delete(API_PATH + '/teams/' + teamId + '.json')
export const deleteUserFromTeam = (teamId, userId) => axios.delete(API_PATH + /teams/ + teamId + '/remove_user/' + userId + '.json')
export const updateTournament = (tournamentId, tournament) => axios.patch(API_PATH + '/tournaments/' + tournamentId + '.json', { tournament: tournament })
export const addUser = (teamId, userId) => axios.post(API_PATH + '/teams/' + teamId + '/add_user/' + userId + '.json')
export const updateMatchStarted = (matchId) => axios.patch(API_PATH + '/matches/' + matchId + '.json', { match: { status: 'in_progress' } })
export const updateMatchFinished = (points1, points2, matchId) => axios.patch(API_PATH + '/matches/' + matchId + '.json', { match: { status: 'finished', points_for_team1: points1, points_for_team2: points2 } })
export const postMatch = (match, team1, team2, users1, users2) => axios.post(API_PATH + '/matches.json', { match: match, team_1: team1, team_2: team2, users_for_team1: users1, users_for_team2: users2 })

axios.interceptors.response.use(function (response) {
  return response
}, function (error) {
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
