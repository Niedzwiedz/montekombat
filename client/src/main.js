// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import VueRouter from 'vue-router'

import App from './App.vue'
import Matches from './components/Matches.vue'
import Tournaments from './components/Tournaments.vue'
import ShowTournament from './components/ShowTournament.vue'
import TournamentTeams from './components/TournamentTeams.vue'
import TournamentRounds from './components/TournamentRounds.vue'
import Login from './components/Login.vue'
import Error from './components/Error.vue'
import Auth from './auth/auth'

Vue.use(VueRouter)

const routes = [
  {
    path: '/matches',
    name: 'matches',
    component: Matches
  },
  {
    path: '/tournaments',
    name: 'tournaments',
    component: Tournaments
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

/* eslint-disable no-new */
new Vue({
  router,
  render: h => h(App)
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
