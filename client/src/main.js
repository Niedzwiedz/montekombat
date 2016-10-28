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
import EditTournament from './components/EditTournament.vue'
import Login from './components/Login.vue'
import Error from './components/Error.vue'
import Auth from './auth/auth'
import { getTournaments, getUsers, postNewTournament, getGames, getTournamentTypes, updateTournament } from './api'

Vue.use(VueRouter)
Vue.use(Vuex)

const routes = [
  {
    path: '/matches',
    name: 'matches',
    component: Matches
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
        component: TournamentRounds
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
    setTournamentTypes (state, types) {
      state.tournament_types = types
    },
    editTournament (state, tournament) {
      state.tournaments[state.tournaments.findIndex(({ id }) => id === tournament['id'])] = tournament
    }
  },
  actions: {
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
      console.log(tournamentParams)
      var tournament = await updateTournament(tournamentParams['id'], tournamentParams['tournament'])
      commit('editTournament', tournament.data)
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
  }
}).$mount('#app')

router.beforeEach((to, from, next) => {
  if (!(to.path === '/login')) {
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
