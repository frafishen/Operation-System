<template>
    <!--上方的進度圖-->
    <el-card class="box-card is-plain" v-if="currentRow">
        <template #header>
            <div class="card-header">
                <span>客戶名稱: {{ currentRow.name }}</span>
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
            <el-table-column type="index" width="50" />
            <el-table-column property="cus_id" label="ID" />
            <el-table-column property="name" label="姓名" />
            <el-table-column property="mail" label="email" />
            <el-table-column property="date" label="最近購買日期" />
            <el-table-column sortable property="clv" label="終身價值" />
            <el-table-column>
                <template #header>
                    <el-input v-model="search" size="small" placeholder="Type to search" /> <!--Search by name-->
                </template>
            </el-table-column>
        </el-table>
        <div class="button-container">
            <el-button @click="clear()">Clear selection</el-button>
        </div>
    </div>
</template>

<script setup>
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
      data.name.toLowerCase().includes(search.value.toLowerCase())
  )
)

const tableData = [
    {
        cus_id: '10000001',
        name: 'AAA',
        mail: 'a@gmail.com',
        date: '2023-11-02',
        clv: 9835
    },
    {
        cus_id: '10000002',
        name: 'BBB',
        mail: 'b@gmail.com',
        date: '2023-11-01',
        clv: 356
    },
    {
        cus_id: '10000003',
        name: 'CCC',
        mail: 'c@gmail.com',
        date: '2023-11-20',
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

</script>
    
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