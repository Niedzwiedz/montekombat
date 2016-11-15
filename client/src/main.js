// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import { sync } from 'vuex-router-sync'
import VueRouter from 'vue-router'
import Vuex from 'vuex'

import App from './App.vue'
import Matches from './components/Matches.vue'
import Tournaments from './components/Tournaments.vue'
import ShowTournament from './components/ShowTournament.vue'
import TournamentTeams from './components/TournamentTeams.vue'
import TournamentRounds from './components/TournamentRounds.vue'
import NewTournament from './components/NewTournament.vue'
import NewFriendlyMatch from './components/NewFriendlyMatch.vue'
import EditTournament from './components/EditTournament.vue'
import MatchInProgress from './components/MatchInProgress.vue'
import Login from './components/Login.vue'
import Signup from './components/SignUp.vue'
import Error from './components/Error.vue'
import Auth from './auth/auth'
import { getMatches, getTournaments, getTournament, getUsers, postNewTournament, getGames, getTournamentTypes, updateTournament, updateMatchFinished, updateMatchStarted, postMatch } from './api'

Vue.use(VueRouter)
Vue.use(Vuex)

const routes = [
  {
    path: '/matches',
    name: 'matches',
    component: Matches,
    children: [
      {
        path: 'new',
        name: 'newFriendlyMatch',
        component: NewFriendlyMatch
      }
    ]
  },
  {
    path: '/tournaments',
    name: 'tournaments',
    component: Tournaments,
    children: [
      {
        path: 'new',
        name: 'newTournament',
        component: NewTournament
      }
    ]
  },
  {
    path: '/tournament/:id',
    name: 'showTournament',
    component: ShowTournament,
    children: [
      {
        path: 'teams',
        name: 'tournamentTeams',
        component: TournamentTeams
      },
      {
        path: 'rounds',
        name: 'tournamentRounds',
        component: TournamentRounds,
        children: [
          {
            path: 'points/:match_id',
            name: 'matchPoints',
            component: MatchInProgress
          }
        ]
      },
      {
        path: 'edit',
        name: 'tournamentEdit',
        component: EditTournament
      }
    ]
  },
  {
    path: '/login',
    name: 'login',
    component: Login
  },
  {
    path: '/signup',
    name: 'signup',
    component: Signup
  },
  {
    path: '/error',
    name: 'error',
    component: Error
  }
]

export const router = new VueRouter({
  routes
})

const store = new Vuex.Store({
  state: {
    tournaments: [],
    matches: [],
    users: [],
    games: [],
    tournament_types: []
  },
  getters: {
    friendlyMatches: state => {
      /* eslint-disable camelcase */
      return state.matches.filter(({ match_type }) => match_type === 'friendly')
      /* eslint-enable camelcase */
    },
    currentTournament: (state, route) => {
      console.log(route.params.id)
      return state.tournaments.find(({ id }) => id === route.params.id)
    },
    currentMatch: (state, route) => {
      return state.matches.find(({ id }) => id === route.params.match_id)
    },
    currentRound: (state, route) => {
      return state.matches.find(({ id }) => id === route.params.round_id)
    }
  },
  mutations: {
    addTournament (state, tournament) {
      state.tournaments.push(tournament)
    },
    addMatch (state, match) {
      state.matches.push(match)
    },
    setTournaments (state, tournaments) {
      state.tournaments = tournaments
    },
    setUsers (state, users) {
      state.users = users
    },
    setGames (state, games) {
      state.games = games
    },
    setMatches (state, matches) {
      state.matches = matches
    },
    setTournamentTypes (state, types) {
      state.tournament_types = types
    },
    editTournament (state, tournament) {
      state.tournaments[state.tournaments.findIndex(({ id }) => id === tournament['id'])] = tournament
    },
    editMatch (state, match) {
      state.matches[state.matches.findIndex(({ id }) => id === match['id'])] = match
    }
  },
  actions: {
    async getOneTournament ({commit}, tournamentId) {
      let tournament = await getTournament(tournamentId)
      commit('editTournament', tournament)
    },
    async addFriendlyMatch ({commit}, matchParams) {
      let match = await postMatch(matchParams.match, matchParams.team1, matchParams.team2, matchParams.usersForTeam1, matchParams.usersForTeam2)
      commit('addMatch', match.data)
    },
    async finishThisMatch ({commit}, matchObject) {
      let match = await updateMatchFinished(matchObject.points1, matchObject.points2, matchObject.matchId)
      commit('editMatch', match.data)
    },
    async startThisMatch ({commit}, matchId) {
      let match = await updateMatchStarted(matchId)
      commit('editMatch', match.data)
    },
    async addNewTournament ({commit}, tournamentParams) {
      let tournament = await postNewTournament(tournamentParams.tournament, tournamentParams.teams)
      commit('addTournament', tournament.data)
    },
    async getAllTournaments ({commit}) {
      let tournaments = await getTournaments()
      commit('setTournaments', tournaments.data)
    },
    async getAllUsers ({commit}) {
      let users = await getUsers()
      commit('setUsers', users.data)
    },
    async getAllGames ({commit}) {
      let games = await getGames()
      commit('setGames', games.data)
    },
    async getAllTournamentTypes ({commit}) {
      let types = await getTournamentTypes()
      commit('setTournamentTypes', types.data)
    },
    async editOneTournament ({commit}, tournamentParams) {
      let tournament = await updateTournament(tournamentParams['id'], tournamentParams['tournament'])
      commit('editTournament', tournament.data)
    },
    async getAllMatches ({commit}) {
      let matches = await getMatches()
      commit('setMatches', matches.data)
    }
  }
})

sync(store, router)
/* eslint-disable no-new */
new Vue({
  router,
  store,
  render: h => h(App),
  async beforeMount () {
    this.$store.dispatch('getAllTournaments')
    this.$store.dispatch('getAllUsers')
    this.$store.dispatch('getAllGames')
    this.$store.dispatch('getAllTournamentTypes')
    this.$store.dispatch('getAllMatches')
  }
}).$mount('#app')

router.beforeEach((to, from, next) => {
  if (!(to.path === '/login') && !(to.path === '/signup')) {
    Auth.checkAuth()
    if (Auth.user.authenticated === true) {
      next()
    } else if (Auth.user.authenticated === false) {
      router.push({name: 'login'})
    }
  } else {
    if (!(Auth.user.authenticated === true)) {
      next()
    }
  }
})
