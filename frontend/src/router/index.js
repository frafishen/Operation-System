// router/index.js
import { createRouter, createWebHistory } from 'vue-router';

import MaterialOrderQueryPage from '../views/MaterialOrderQueryPage.vue'

const routes = [
  { path: '/', name: 'MaterialOrderQueryPage', component: MaterialOrderQueryPage },
  // { path: '/material-order-query', name: 'MaterialOrderQueryPage', component: MaterialOrderQueryPage },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
