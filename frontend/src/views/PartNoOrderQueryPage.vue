<template>
  <div class="select">
    <el-select v-model="selectedOption" placeholder="Select" size="default" @change="handleSelectionChange">
      <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value" />
    </el-select>
  </div>
  <el-main>
    <!--上方的進度圖-->
    <el-card class="box-card is-plain">
      <template #header>
        <div class="card-header">
          <span>訂單編號: {{ order_data.id }}</span>
          <span>交貨日期: {{ order_data.lead_time }}</span>
        </div>
      </template>
      <!--card body-->
      <div class="demo-progress">
        <template v-for="step in step_data">
          <el-progress type="dashboard" :percentage="step.percentage" :stroke-width="10"
            :status="step.percentage === 100 ? 'success' : ''">
            <template v-if="step.percentage < 100">
              <span class="percentage-value">{{ step.percentage }}%</span>
              <span class="percentage-label">{{ step.process }}</span>
            </template>
            <template v-if="step.percentage === 100">
              <el-button type="success" circle><el-icon><Check /></el-icon></el-button>
              <span class="percentage-label">{{ step.process }}</span>
            </template>
          </el-progress>
        </template>
      </div>
    </el-card>
    <!--下方的表格-->
    <div class="table_part">
      <el-table ref="singleTableRef" :data="productOrders" highlight-current-row style="width: 100%"
        @current-change="handleRowClick">
        <!-- <el-table-column type="index" width="50" /> -->
        <el-table-column property="order_id" label="訂單編號" width="120" />
        <el-table-column property="product_name" label="料號" width="120" />
        <el-table-column property="machine_id" label="機台" />
        <el-table-column property="order_created_at" label="訂購日期" />
        <el-table-column property="order_delivered_at" label="交貨日期" />
      </el-table>
    </div>
  </el-main>
</template>

<script>
import { ElTable, ElCard } from 'element-plus';
import { fetchProductOrders, fetchProductOrderProgress } from '@/api/PartNoOrderQueryAPI';
import { Check } from '@element-plus/icons-vue'

export default {
  data() {
    return {
      selectedOption: null,
      options: [
        { id: 1, label: 'PCB式', value: 'PCB式' },
        { id: 2, label: '柵板式', value: '柵板式' },
        { id: 3, label: '軌道式', value: '軌道式' },
        { id: 4, label: '客製端子台', value: '客製端子台' }
      ],
      productOrders: [],
      order_data: {
        order_id: null,
        product_id: null,
        product_name: '',
        machine_id: null,
        order_created_at: '',
        order_delivered_at: null
      },
      step_data: [
        {
          process: "建模",
          percentage: 100
        },
        {
          process: "製造",
          percentage: 70
        },
        {
          process: "運送",
          percentage: 0
        }
      ],
      currentRow: null,
      singleTableRef: null
    };
  },
  methods: {
    async fetchProductOrdersData() {
      try {
        this.productOrders = await fetchProductOrders();
      } catch (error) {
        console.error('Error fetching product orders:', error);
      }
    },
    async fetchAndUpdateOrderProgress(orderId, productId) {
      try {
        const progressData = await fetchProductOrderProgress(orderId, productId);
        // Update step_data based on the fetched progress data
        this.updateStepDataWithProgress(progressData);
      } catch (error) {
        console.error('Error fetching product order progress:', error);
      }
    },
    updateStepDataWithProgress(progressData) {
      if (progressData.length > 0) {
        const currentStage = progressData[0].progress.stage;
        const completeness = progressData[0].progress.completeness;

        this.step_data.forEach((step, index) => {
          if (index < currentStage) {
            step.percentage = 100;
          } else if (index === currentStage) {
            step.percentage = completeness;
          } else {
            step.percentage = 0;
          }
        });
      }
    },
    handleRowClick(row) {
      this.order_data = { ...row };
      this.fetchAndUpdateOrderProgress(row.order_id, row.product_id);
    },
    handleSelectionChange() {
      // 在這裡執行你想要觸發的功能
      console.log('Selected option:', this.selectedOption);
    }
  },
  mounted() {
    this.fetchProductOrdersData();
  }
};
</script>

<style>

.select {
    position: fixed;
    top: 9%;
    right: 1.5%;
    z-index: 99;
}

.main-part {
  width: calc(100% - 18%);
}

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
  margin-bottom: 10px;
}

.card-header {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: left;
  padding: 3px 5px;
}

.percentage-value {
  display: block;
  margin-top: 10px;
  font-size: 24px;
}

.percentage-label {
  display: block;
  margin-top: 10px;
  font-size: 14px;
}

.demo-progress {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 3%;
  /* 調整 el-progress 之間的間距 */
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