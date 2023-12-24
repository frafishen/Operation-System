<template>
  <el-card class="box-card">
    <h1>Material Orders</h1>
    <el-list>
      <el-list-item 
        v-for="order in materialOrders" 
        :key="order.material_order_id">
        {{ order.material_name }} - {{ order.quantity }}
      </el-list-item>
    </el-list>
  </el-card>
</template>

<script>
import { fetchMaterialOrders } from '@/api/MaterialOrderQueryAPI';

export default {
  data() {
    return {
      materialOrders: []
    };
  },
  async mounted() {
    try {
      this.materialOrders = await fetchMaterialOrders();
    } catch (error) {
      console.error('Error fetching material orders:', error);
    }
  }
};
</script>


<style>
.box-card {
  margin: 20px;
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
}
</style>
