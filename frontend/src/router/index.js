// router/index.js
import { createRouter, createWebHistory } from 'vue-router';

import MaterialOrderQueryPage from '../views/MaterialOrderQueryPage.vue'
import PartNoOrderQueryPage from '../views/PartNoOrderQueryPage.vue'
import InventoryManPage from '../views/InventoryManPage.vue'
import CustomerManPage from '../views/CustomerManPage.vue'
import ProductionOrderManPage from '../views/ProductionOrderManPage.vue'

const routes = [
  // { path: '/', name: 'TestPage', component: TestPage },
  { path: '/', name: 'MaterialOrderQueryPage', component: PartNoOrderQueryPage },
  { path: '/PartNoOrderQueryPage', name: 'PartNoOrderQueryPage', component: PartNoOrderQueryPage },
  { path: '/InventoryManPage', name: 'InventoryManPage', component: InventoryManPage },
  { path: '/MaterialOrderQueryPage', name: 'MaterialOrderQueryPage', component: MaterialOrderQueryPage },
  { path: '/CustomerManPage', name: 'CustomerManPage', component: CustomerManPage},
  { path: '/ProductionOrderManPage', name: 'ProductionOrderManPage', component: ProductionOrderManPage},

];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
