<template>
    <div>
      <ul>
        <li v-for="order in materialOrders" :key="order.material_order_id">
          {{ order.material_name }} - {{ order.quantity }}
        </li>
      </ul>
    </div>
  </template>
  
  <script>
  import { fetchMaterialOrders } from '../api/MaterialOrderQueryAPI';
  
  export default {
    data() {
      return {
        materialOrders: []
      };
    },
    async mounted() {
      this.materialOrders = await fetchMaterialOrders();
    }
  };
  </script>
  