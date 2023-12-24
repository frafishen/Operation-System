<template>
  <!--上方的進度圖-->
  <el-card class="box-card is-plain">
    <template #header>
      <div class="card-header">
        <span>訂單編號: {{ order_data.id }}</span>
        <span>交貨日期: {{ order_data.delivered_at }}</span>
        <!-- <el-button class="button" text>Operation button</el-button> -->
      </div>
    </template>
    <el-steps :active="lastActiveStageIndex" align-center>
      <el-step v-for="stage in stage_data" :key="stage.name" :title="stage.name" :description="stage.description" />
    </el-steps>
    <!-- <div v-for="o in 4" :key="o" class="text item">{{ 'List item ' + o }}</div> -->
  </el-card>
  <!--下方的表格-->
  <div class="table_part">
    <el-table ref="singleTableRef" :data="tableData" highlight-current-row style="width: 100%"
      @current-change="handleCurrentChange">
      <el-table-column type="index" width="50" />
      <el-table-column property="material_order_id" label="訂單編號" width="120" />
      <el-table-column property="material_name" label="原物料名稱" width="120" />
      <el-table-column property="quantity" label="訂單總額" />
      <el-table-column property="created_at" label="訂購日期" />
      <el-table-column property="delivered_at" label="交貨日期" />
      <el-table-column property="progress" label="訂單進度" />
    </el-table>
    <!-- <div style="padding: 0.5% 2%;">
            <el-button @click="setCurrent(tableData[1])">Select second row</el-button>
            <el-button @click="setCurrent()">Clear selection</el-button>
        </div> -->
  </div>
</template>
  
  
<script setup>
import { ref } from "vue"
import { ElTable, ElCard } from 'element-plus'
import { fetchMaterialOrders } from '@/api/MaterialOrderQueryAPI';
// import axios from 'axios'

const order_data = ref({
  id: "103301",
  delivered_at: "2023-12-02"
})

const stage_data = ref([
  {
    name: "Step 1",
    description: "Some description",
    active: "True"
  },
  {
    name: "Step 2",
    description: "Some description",
    active: "True"
  },
  {
    name: "Step 3",
    description: "Some description",
    active: "True"
  },
  {
    name: "Step 4",
    description: "Some description",
    active: "True"
  }
])

const lastActiveStageIndex = ref(-1)

// 表格
const currentRow = ref();
const singleTableRef = ref();

const tableData = [
  {
    material_order_id: '10384',
    material_name: '銅',
    quantity: '100',
    created_at: '2023-12-22',
    delivered_at: '2024-1-3',
    progress: '未完成'
  },
  {
    material_order_id: '10385',
    material_name: '鋁',
    quantity: '200',
    created_at: '2023-12-23',
    delivered_at: '2024-1-4',
    progress: '進行中'
  },
  {
    material_order_id: '10386',
    material_name: '鋼',
    quantity: '300',
    created_at: '2023-12-24',
    delivered_at: '2024-1-5',
    progress: '已完成'
  },
  {
    material_order_id: '10387',
    material_name: '錫',
    quantity: '400',
    created_at: '2023-12-25',
    delivered_at: '2024-1-6',
    progress: '延遲'
  }
];

//  function

// const setCurrent = (row) => {
//   singleTableRef.value.setCurrentRow(row);
// };

const judgeActiveStage = () => {
  // 找到所有 active 屬性為 true 的 stage
  const activeStages = stage_data.value.filter(stage => stage.active === "True");

  // 如果沒有 active 屬性為 true 的階段，則返回 null 或者你認為合適的預設值
  if (activeStages.length === 0) {
    return null;
  }

  // 找到最後一個 active 屬性為 true 的階段
  const lastActiveStage = ref(activeStages[activeStages.length - 1])
  lastActiveStageIndex.value = stage_data.value.lastIndexOf(lastActiveStage.value) + 1;
  console.log(lastActiveStageIndex.value)
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
  height: 45%;
  min-height: 250px;
  /* 覆蓋 */
  border-radius: 0;
}

.card-header {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: left;
  padding: 3px 5px;
}

.text {
  font-size: 14px;
}

.item {
  margin-bottom: 18px;
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
  height: calc(100% - 7% - 45%);
  /* min-height: 250px */
}
</style>