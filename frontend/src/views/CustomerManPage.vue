<template>
  <!--上方的進度圖-->
  <el-card class="box-card is-plain" v-if="currentRow">
    <template #header>
      <div class="card-header">
        <span>客戶名稱: {{ currentRow.client_name }}</span>
      </div>
    </template>
    <!-- 統計圖表 -->
    <div class="chart-container">
      <BarChart :chartData="chartData_LHS" />
      <LineChart :chartData="chartData_RHS" />
    </div>
  </el-card>
  <!--下方的表格-->
  <div :class="table_part">
    <el-table ref="singleTableRef" :data="filterTableData" highlight-current-row style="width: 100%"
      @current-change="handleCurrentChange">
      <!-- <el-table-column type="index" width="50" /> -->
      <el-table-column property="client_id" label="客戶編號" />
      <el-table-column property="client_name" label="姓名" />
      <el-table-column property="mail" label="email" />
      <el-table-column property="created_at" label="最近購買日期" />
      <el-table-column sortable property="clv" label="終身價值" />
      <el-table-column>
        <template #header>
          <el-input v-model="search" size="small" placeholder="Type to search" /> <!--Search by client_name-->
        </template>
      </el-table-column>
    </el-table>
    <div class="button-container">
      <el-button @click="clear()">Clear selection</el-button>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, reactive } from 'vue'
import { ElTable, ElCard } from 'element-plus'
import BarChart from '@/components/BarChartWithLine.vue'
import LineChart from '@/components/LineChartForCus.vue'
import { fetchClients, fetchClientById, fetchCompanyRevenue, fetchRevenueGrowthRates, fetchAveragePurchaseInterval } from '@/api/CustomerManAPI'

const chartData_LHS = reactive({
  xAxisData: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  yAxisRev: [150, 230, 224, 218, 328, 400, 468],
  yAxisGrowthRate: [10, 14, 13, 15, 9, 8, 7]
})

const chartData_RHS = reactive({
  xAxisData: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  yAxisInterval: [20, 16, 17, 14, 13, 9, 8],
})

const currentRow = ref()
const singleTableRef = ref()
const table_part = ref('table_part')
const search = ref('')

// Initialize tableData as a reactive reference
const tableData = ref([])


// Function to fetch clients and update tableData
const loadClients = async () => {
  try {
    const clients = await fetchClients()
    tableData.value = clients.map(client => ({
      client_id: client.client_id.toString(),
      client_name: client.client_name,
      mail: client.email,
      created_at: new Date(client.created_at).toLocaleDateString(),
      clv: client.clv.toFixed(2)
    }))
  } catch (error) {
    console.error('Error fetching client data:', error)
  }
}

// Function to fetch company revenue and update chartData_LHS
const loadCompany = async (clientId) => {
  try {
    // Fetch both revenue and growth rates concurrently
    const [revenueResponse, growthRateResponse] = await Promise.all([
      fetchCompanyRevenue(clientId),
      fetchRevenueGrowthRates(clientId)
    ]);

    const revenueData = revenueResponse[0].revenue;
    const growthRatesData = growthRateResponse[0]['growth rates'];

    // console.log(revenueData)
    // console.log(growthRatesData)

    // Assuming both revenueData and growthRatesData have the same keys (months)
    chartData_LHS.xAxisData = Object.keys(revenueData);

    // Update yAxisRev and yAxisGrowthRate
    chartData_LHS.yAxisRev = Object.values(revenueData);
    chartData_LHS.yAxisGrowthRate = Object.values(growthRatesData);
  } catch (error) {
    console.error('Error fetching company data:', error);
  }
};

const loadPurchaseInterval = async (clientId) => {
  try {
    const [pruchaseIntervalResponse] = await Promise.all([
      fetchAveragePurchaseInterval(clientId)
    ]);
    
    const intervalData = pruchaseIntervalResponse[0]['avg_purchase_interval'];
    // console.log(intervalData)

    // Assuming both revenueData and growthRatesData have the same keys (months)
    chartData_RHS.xAxisData = Object.keys(intervalData);

    // Update yAxisRev and yAxisGrowthRate
    chartData_RHS.yAxisInterval = Object.values(intervalData);

    // console.log(chartData_RHS.xAxisData)
    // console.log(chartData_RHS.yAxisInterval)
  } catch (error) {
    console.error('Error fetching company data:', error);
  }
};

// Call loadClients when the component is mounted
onMounted(async () => {
  await loadClients();
  await loadCompany(2);
});

// Filter function for the table
const filterTableData = computed(() =>
  tableData.value.filter(
    data =>
      !search.value ||
      data.client_name.toLowerCase().includes(search.value.toLowerCase())
  )
)

// Clear the current row selection
const clear = () => {
  currentRow.value = null
  table_part.value = 'table_part'
}

const handleCurrentChange = async (val) => {
  if (val && val.client_id) {
    currentRow.value = val;
    table_part.value = 'table_part_half';
    // console.log(val.client_id)
    // Call loadCompany with the client_id of the selected row
    console.log(val.client_id)
    loadCompany(val.client_id);
    loadPurchaseInterval(val.client_id)
  }
};

</script>




<!-- <script setup>
import { ref, computed } from "vue"
import { ElTable, ElCard } from 'element-plus'
import BarChart from '@/components/BarChartWithLine.vue'
import LineChart from '@/components/LineChartForCus.vue'


const chartData_LHS = ref({
    xAxisData: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    yAxisRev: [150, 230, 224, 218, 328, 400, 468],
    yAxisGrowthRate: [10, 14, 13, 15, 9, 8, 7]
})

const chartData_RHS = ref({
    xAxisData: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    yAxisInterval: [20, 16, 17, 14, 13, 9, 8],
})

// 表格
const currentRow = ref()
const singleTableRef = ref()

const table_part = ref('table_part') //for css class 切換

const search = ref('')
const filterTableData = computed(() =>
  tableData.filter(
    (data) =>
      !search.value ||
      data.client_name.toLowerCase().includes(search.value.toLowerCase())
  )
)

const tableData = [
    {
        client_id: '10000001',
        client_name: 'AAA',
        mail: 'a@gmail.com',
        created_at: '2023-11-02',
        clv: 9835
    },
    {
        client_id: '10000002',
        client_name: 'BBB',
        mail: 'b@gmail.com',
        created_at: '2023-11-01',
        clv: 356
    },
    {
        client_id: '10000003',
        client_name: 'CCC',
        mail: 'c@gmail.com',
        created_at: '2023-11-20',
        clv: 98356
    }
];

// 清除選取的row
const clear = () => {
    currentRow.value = null
    table_part.value = 'table_part'
}

const handleCurrentChange = (val) => {
    currentRow.value = val;
    console.log(val)
    table_part.value = 'table_part_half'

};

</script> -->
    
<style scoped>
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
  padding: 0;
  margin: 0;
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
  height: calc(100% - 7%);
  border-left: 0.5px solid #ccc;
  /* 外框樣式，可根據需要調整 */
  overflow: hidden;
  /* 如果有需要隱藏內容溢出的部分 */
  /* min-height: 250px */
}

.table_part_half {
  background-color: var(--vt-c-white-soft);
  display: flex;
  flex-direction: column;
  position: fixed;
  bottom: 0%;
  left: 18%;
  right: 0;
  width: calc(100% - 18%);
  height: calc(100% - 7% - 55%);
  border-left: 0.5px solid #ccc;
  /* 外框樣式，可根據需要調整 */
  overflow: hidden;
  /* 如果有需要隱藏內容溢出的部分 */
  /* min-height: 250px */
}

.button-container {
  display: flex;
  justify-content: center;
  padding: 0.5% 2%;
}

.chart-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  /* 兩列，每列平均分配空間 */
  gap: 16px;
  /* 可以根據需要調整列之間的間距 */
}
</style>