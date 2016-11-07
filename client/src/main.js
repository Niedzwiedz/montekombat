// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
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
import { getMatches, getTournaments, getTournament, getUsers, postNewTournament, getGames, getTournamentTypes, updateTournament, updateMatchFinished, updateMatchStarted } from './api'

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
  mutations: {
    addTournament (state, tournament) {
      state.tournaments.push(tournament)
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
      var tournament = await getTournament(tournamentId)
      commit('editTournament', tournament)
    },
    async finishThisMatch ({commit}, matchObject) {
      var match = await updateMatchFinished(matchObject.points1, matchObject.points2, matchObject.matchId)
      commit('editMatch', match.data)
    },
    async startThisMatch ({commit}, matchId) {
      var match = await updateMatchStarted(matchId)
      commit('editMatch', match.data)
    },
    async addNewTournament ({commit}, tournamentParams) {
      var tournament = await postNewTournament(tournamentParams.tournament, tournamentParams.teams)
      commit('addTournament', tournament.data)
    },
    async getAllTournaments ({commit}) {
      var tournaments = await getTournaments()
      commit('setTournaments', tournaments.data)
    },
    async getAllUsers ({commit}) {
      var users = await getUsers()
      commit('setUsers', users.data)
    },
    async getAllGames ({commit}) {
      var games = await getGames()
      commit('setGames', games.data)
    },
    async getAllTournamentTypes ({commit}) {
      var types = await getTournamentTypes()
      commit('setTournamentTypes', types.data)
    },
    async editOneTournament ({commit}, tournamentParams) {
      var tournament = await updateTournament(tournamentParams['id'], tournamentParams['tournament'])
      commit('editTournament', tournament.data)
    },
    async getAllMatches ({commit}) {
      var matches = await getMatches()
      commit('setMatches', matches.data)
    }
  }
})

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
    if (Auth.user.authenticated === false) {
      router.push({name: 'login'})
    } else {
      next()
    }
  } else {
    next()
  }
})
