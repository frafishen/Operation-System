// router/index.js
import { createRouter, createWebHistory } from 'vue-router';

import MaterialOrderQueryPage from '../views/MaterialOrderQueryPage.vue'
import TestPage from '../views/TestPage.vue'

const routes = [
  { path: '/', name: 'TestPage', component: TestPage },
  { path: '/material-order-query', name: 'MaterialOrderQueryPage', component: MaterialOrderQueryPage },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
