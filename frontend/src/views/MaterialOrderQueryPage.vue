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
    <el-table ref="singleTableRef" :data="materialOrders" highlight-current-row style="width: 100%"
      @current-change="handleRowClick">
      <el-table-column type="index" width="50" />
      <el-table-column property="material_order_id" label="訂單編號" width="120" />
      <el-table-column property="material_name" label="原物料名稱" width="120" />
      <el-table-column property="quantity" label="訂單總額" />
      <el-table-column property="created_at" label="訂購日期" />
      <el-table-column property="delivered_at" label="交貨日期" />
      <!-- <el-table-column property="progress" label="訂單進度" /> -->
    </el-table>
    <!-- <div style="padding: 0.5% 2%;">
            <el-button @click="setCurrent(tableData[1])">Select second row</el-button>
            <el-button @click="setCurrent()">Clear selection</el-button>
        </div> -->
  </div>
</template>
  


  
<script>
import { ref, onMounted } from "vue";
import { ElTable, ElCard } from 'element-plus';
import { fetchMaterialOrders } from '@/api/MaterialOrderQueryAPI';

export default {
  data() {
    return {
      materialOrders: [],
      order_data: {
        id: "103301",
        delivered_at: "2023-12-02"
      },
      stage_data: [
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
      ],
      lastActiveStageIndex: -1,
      currentRow: null,
      singleTableRef: null
    };
  },
  methods: {
    async fetchMaterialOrdersData() {
      try {
        this.materialOrders = await fetchMaterialOrders();
      } catch (error) {
        console.error('Error fetching material orders:', error);
      }
    },
    judgeActiveStage() {
      const activeStages = this.stage_data.filter(stage => stage.active === "True");

      if (activeStages.length === 0) {
        return null;
      }

      const lastActiveStage = activeStages[activeStages.length - 1];
      this.lastActiveStageIndex = this.stage_data.lastIndexOf(lastActiveStage) + 1;
      console.log(this.lastActiveStageIndex);
    },
    // handleCurrentChange(val) {
    //   this.currentRow = val;
    //   console.log(val);
    //   this.judgeActiveStage();
    // },
    handleRowClick(row) {
      this.order_data = row;
      this.createStageData(row.progress);
    },
    createStageData(progress) {
      const newStageData = Object.keys(progress).map((key, index) => {
        return {
          name: `Step ${index + 1}`,
          description: progress[key],
          active: progress[key].includes('order completed')
        };
      });

      this.stage_data = newStageData;
      this.updateLastActiveStageIndex();
    },
    updateLastActiveStageIndex() {
      const lastIndex = this.stage_data.findIndex(stage => stage.active);
      this.lastActiveStageIndex = lastIndex >= 0 ? lastIndex : 0;
    }
  },
  mounted() {
    this.fetchMaterialOrdersData();
  }
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