// router/index.js
import { createRouter, createWebHistory } from 'vue-router';

import MaterialOrderQueryPage from '../views/MaterialOrderQueryPage.vue'
import PartNoOrderQueryPage from '../views/PartNoOrderQueryPage.vue'
import InventoryManPage from '../views/InventoryManPage.vue'

const routes = [
  { path: '/', name: 'MaterialOrderQueryPage', component: PartNoOrderQueryPage },
  { path: '/PartNoOrderQueryPage', name: 'PartNoOrderQueryPage', component: PartNoOrderQueryPage },
  { path: '/InventoryManPage', name: 'InventoryManPage', component: InventoryManPage },
  { path: '/MaterialOrderQueryPage', name: 'MaterialOrderQueryPage', component: MaterialOrderQueryPage },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
