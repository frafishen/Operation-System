<template>
    <!--上方的進度圖-->
    <el-card class="box-card is-plain">
      <template #header>
        <div class="card-header">
          <span>料號: {{ currentRow.product_name }} ｜ 數量: {{ currentRow.quantity }}</span>
        </div>
      </template>
      <!-- 統計圖表 -->
      <div>
        <LineChart :chartData="chartData"/>
      </div>
    </el-card>
    <!--下方的表格-->
    <div class="table_part">
      <el-table ref="singleTableRef" :data="tableData" highlight-current-row style="width: 100%"
        @current-change="handleRowClick">
        <el-table-column type="index" width="50" />
        <el-table-column property="product_name" label="料號" />
        <el-table-column property="quantity" label="庫存數量" />
        <el-table-column property="required_product_id" label="所需材料" />
      </el-table>
    </div>
  </template>

  <script setup>
  import { ref, onMounted } from "vue";
  import { ElTable, ElCard } from 'element-plus';
  import LineChart from '@/components/LineChart.vue';
  import { watch } from "vue";
  import { fetchInventory, fetchProductOrderProgress } from '@/api/InventoryManAPI';
  
  const tableData = ref([]);
  const chartData = ref({
    xAxisData: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    yAxisSales: [150, 230, 224, 218],
    yAxisForcast: [150, 230, 224, 218, 135, 147, 260]
  });
  const currentRow = ref({}); // Define currentRow to store selected row data
  
  // Fetch inventory data and update table
  const loadInventoryData = async () => {
    const productData = await fetchInventory();
    tableData.value = productData.map(product => ({
      product_id: product.product_id,
      product_name: product.product_name,
      quantity: product.quantity,
      required_product_id: product.required_product_id
    }));
  };
  
  // Fetch product order progress data and update chart
  const loadProductOrderProgress = async (productId) => {
    const orderProgressData = await fetchProductOrderProgress(productId);
    // console.log(orderProgressData);
    chartData.value.xAxisData = orderProgressData.map(data => new Date(data.consumed_date).toLocaleDateString());
    chartData.value.yAxisForcast = orderProgressData.map(data => data.consumed_quantity);
    chartData.value.yAxisSales = chartData.value.yAxisForcast.slice(0, 15);
    console.log(chartData.value.xAxisData);
    console.log(chartData.value.yAxisForcast);
    console.log(chartData.value.yAxisSales);
  };
  
  // Handle row click to fetch and display product order progress
  const handleRowClick = (row) => {
    currentRow.value = row; // Update currentRow with the selected row data
    loadProductOrderProgress(row.product_id);
  };
  
  watch(chartData, (newVal) => {
  console.log("Chart Data Updated:", newVal);
}, { deep: true });

  // Load initial inventory data
  onMounted(loadInventoryData);
  
  </script>
  

    
  <style>
  .box-card {
    flex-direction: column;
    background-color: var(--vt-c-white-soft);
    display: flex;
    position: fixed;
    top: 7%;
    left: 18%;
    right: 0;
    width: calc(100% - 18%);
    height: 55%;
    min-height: 250px;
    /* 覆蓋 */
    border-radius: 0;
  }
  
  .card-header {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: left;
    padding: 0px 4px;
  }
  
  .text {
    font-size: 14px;
  }
  
  .table_part {
    background-color: var(--vt-c-white-soft);
    display: flex;
    flex-direction: column;
    position: fixed;
    bottom: 0%;
    left: 18%;
    right: 0;
    width: calc(100% - 18%);
    height: calc(100% - 7% - 55%);
    /* min-height: 250px */
  }
  </style>