<template>
    <!--上方的進度圖-->
    <el-card class="box-card is-plain" v-if="currentRow">
        <!-- <template #header>
            <div class="card-header">
                <span>料號: {{ currentRow.part_no }} ｜ 數量: {{ currentRow.inv_amount }}</span>
            </div>
        </template> -->
        <!-- 統計圖表 -->
        <div>
            <!-- <pieChart :chartData="chartData" /> -->
        </div>
    </el-card>
    <!--下方的表格-->
    <div :class="table_part">
        <el-table ref="singleTableRef" :data="tableData" highlight-current-row style="width: 100%"
            @current-change="handleCurrentChange">
            <el-table-column type="index" width="50" />
            <el-table-column property="cus_id" label="ID" />
            <el-table-column property="name" label="姓名" />
            <el-table-column property="mail" label="email" />
            <el-table-column property="date" label="最近購買日期" />
            <el-table-column property="clv" label="終身價值" />
        </el-table>
        <div class="button-container">
            <el-button @click="clear()">Clear selection</el-button>
        </div>
    </div>
</template>
    
    
<script setup>
import { ref } from "vue"
import { ElTable, ElCard } from 'element-plus'
//   import pieChart from '@/components/LineChart.vue'


const chartData = ref({

})

// 表格
const currentRow = ref();
const singleTableRef = ref();

const table_part = ref('table_part')


const tableData = [
    {
        cus_id: '291029',
        name: '100',
        mail: '291022, 291021',
        date: '2023-11-02',
        clv: 98356
    },
    {
        cus_id: '291029',
        name: '100',
        mail: '291022, 291021',
        date: '2023-11-02',
        clv: 98356
    },
    {
        cus_id: '291029',
        name: '100',
        mail: '291022, 291021',
        date: '2023-11-02',
        clv: 98356
    },
    {
        cus_id: '291029',
        name: '100',
        mail: '291022, 291021',
        date: '2023-11-02',
        clv: 98356
    },
    {
        cus_id: '291029',
        name: '100',
        mail: '291022, 291021',
        date: '2023-11-02',
        clv: 98356
    },
    {
        cus_id: '291029',
        name: '100',
        mail: '291022, 291021',
        date: '2023-11-02',
        clv: 98356
    },
    {
        cus_id: '291029',
        name: '100',
        mail: '291022, 291021',
        date: '2023-11-02',
        clv: 98356
    },
    {
        cus_id: '291029',
        name: '100',
        mail: '291022, 291021',
        date: '2023-11-02',
        clv: 98356
    },
    {
        cus_id: '291029',
        name: '100',
        mail: '291022, 291021',
        date: '2023-11-02',
        clv: 98356
    }
];

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
}</style>