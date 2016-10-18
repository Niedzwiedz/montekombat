// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import VueRouter from 'vue-router'

import App from './App.vue'
import Hello from './components/Hello.vue'
import Matches from './components/Matches.vue'
import Login from './components/Login.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/home', component: Hello },
  {
    path: '/matches',
    name: 'matches',
    component: Matches
  },
  {
    path: '/login',
    name: 'login',
    component: Login
  }
]

const router = new VueRouter({
  routes
})

/* eslint-disable no-new */
new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
