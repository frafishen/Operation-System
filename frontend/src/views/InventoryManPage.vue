<template>
    <!--上方的進度圖-->
    <el-card class="box-card is-plain">
      <template #header>
        <div class="card-header">
          <span>料號: {{ order_data.id }} | 數量: {{ order_data.lead_time }}</span>
        </div>
      </template>
      <!-- 統計圖表 -->
      <div>
        <pieChart />
      </div>
    </el-card>
    <!--下方的表格-->
    <div class="table_part">
      <el-table ref="singleTableRef" :data="tableData" highlight-current-row style="width: 100%"
        @current-change="handleCurrentChange">
        <el-table-column type="index" width="50" />
        <el-table-column property="part_no" label="料號" />
        <el-table-column property="inventory" label="庫存數量" />
        <el-table-column property="requirement" label="所需材料" />
      </el-table>
    </div>
  </template>
    
    
  <script setup>
  import { ref } from "vue"
  import { ElTable, ElCard } from 'element-plus'
  import pieChart from '@/components/LineChart.vue'
  
  const order_data = ref({
    id: "103301",
    lead_time: "2023-12-02"
  })
  
 
  const lastActiveStageIndex = ref(-1)
  
  // 表格
  const currentRow = ref();
  const singleTableRef = ref();
  
  const tableData = [
    {
      part_no: '291029',
      inventory: '100',
      requirement: '291022, 291021',
    }
  ];
  
  const judgeActiveStage = () => {

  }
  
  const handleCurrentChange = (val) => {
    currentRow.value = val;
    console.log(val)
    // 接stage data(上方有寫好的格式)
  
  
    // 判斷 active 到哪
    judgeActiveStage()
  };
  
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