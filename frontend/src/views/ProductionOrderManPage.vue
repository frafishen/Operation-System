<template>
    <div class="select">
        <el-select v-model="selectedOption" placeholder="Select" size="default" @change="handleSelectionChange">
            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
    </div>
    <!--上方的Pert Chart-->
    <div>
        <PertChart :chartData="chartData" />
    </div>
    <!--下方的表格-->
    <div class="table-part">
        <el-table ref="singleTableRef" :data="tableData" highlight-current-row style="width: 100%"
            @current-change="handleCurrentChange">
            <el-table-column type="index" />
            <el-table-column property="type" label="種類" />
            <el-table-column property="part_no" label="料號" />
            <el-table-column sortable property="inv_amount" label="庫存" />
        </el-table>
    </div>
</template>

<script setup>
import { ref, computed } from "vue"
import { ElTable, ElCard } from 'element-plus'
import PertChart from '@/components/PertChart.vue'

// 下拉選單
const selectedOption = ref()
const options = ref([
    { id: 1, label: 'PCB式', value: 'PCB式' },
    { id: 2, label: '柵板式', value: '柵板式' },
    { id: 3, label: '軌道式', value: '軌道式' },
    { id: 4, label: '客製端子台', value: '客製端子台' },
])

// Pert Chart Data
const chartData = ref({
    part_no: "QuantumPort8",
    quantity: 30,
    date: "2024-01-10",
    materials: [
        {
            part_no: "CyberLink42",
            quantity: 60,
            date: "2023-12-27",
            materials: [
                {
                    part_no: "NanoGrid41",
                    quantity: 120,
                    date: "2023-12-20",
                    materials: []
                }]
        },
        {
            part_no: "ElectraNode70",
            quantity: 120,
            date: "2023-12-29",
            materials: [
                {
                    part_no: "Screw Set",
                    quantity: 120,
                    date: "2023-12-20",
                    materials: []
                },
                {
                    part_no: "Conductive Gel",
                    quantity: 480,
                    date: "2023-12-23",
                    materials: []
                }]
        }]
})

// Table Data
const currentRow = ref()
const singleTableRef = ref()

const tableData = [
    {
        index: 0,
        type: '柵板式',
        part_no: 'QuantumPort8',
        inv_amount: 20,
    },
    {
        index: 1,
        type: '柵板式',
        part_no: 'NanoGrid7',
        inv_amount: 15,
    },
    {
        index: 2,
        type: '柵板式',
        part_no: 'CyberLink42',
        inv_amount: 15,
    },
    {
        index: 3,
        type: '柵板式',
        part_no: 'ElectraNode70',
        inv_amount: 5,
    }
];

// Function
// 下拉選單
const handleSelectionChange = () => {
    // 在這裡執行你想要觸發的功能
    console.log('Selected option:', selectedOption.value);

}
// 表格row選取
const handleCurrentChange = (val) => {
    currentRow.value = val;
    console.log(val)
    chartData.value = products.value[currentRow.value.index]
};

const products = ref([
    {
        part_no: "QuantumPort8",
        quantity: 20,
        date: "2024-01-10",
        materials: [{
            part_no: "CyberLink42",
            quantity: 20,
            date: "2023-12-27",
            materials: [{
                part_no: "NanoGrid41",
                quantity: 40,
                date: "2023-12-20",
                material: []
            }]
        },
        {
            part_no: "ElectraNode70",
            quantity: 20,
            date: "2023-12-29",
            materials: [{
                part_no: "Screw Set",
                quantity: 60,
                date: "2023-12-20",
                material: []
            },
            {
                part_no: "Conductive Gel",
                quantity: 60,
                date: "2023-12-23",
                material: []
            }
            ]
        }
        ]
    },
    {
        part_no: "NanoGrid7",
        quantity: 90,
        date: "2024-01-10",
        materials: [{
            part_no: "NanoGrid79",
            quantity: 120,
            date: "2023-12-29",
            materials: [{
                part_no: "Mounting Brackets",
                quantity: 120,
                date: "2023-12-20",
                material: []
            },
            {
                part_no: "Circuit Board",
                quantity: 480,
                date: "2023-12-23",
                material: []
            }
            ]
        }]
    },
    {
        part_no: "CyberLink42",
        quantity: 20,
        date: "2023-12-29",
        materials: [{
            part_no: "NanoGrid41",
            quantity: 40,
            date: "2023-12-20",
            material: []
        }]
    },
    {
        part_no: "ElectraNode70",
        quantity: 20,
        date: "2023-12-29",
        materials: [{
            part_no: "Screw Set",
            quantity: 60,
            date: "2023-12-20",
            material: []
        },
        {
            part_no: "Conductive Gel",
            quantity: 60,
            date: "2023-12-23",
            material: []
        }
        ]
    }
])
</script>
    
<style scoped>
.table-part {
    background-color: var(--vt-c-white-soft);
    display: flex;
    flex-direction: column;
    position: fixed;
    bottom: 0%;
    left: 18%;
    right: 0;
    width: calc(100% - 18%);
    height: calc(100% - 7% - 55%);
    /* border-left: 0.5px solid #ccc; */
    /* 外框樣式，可根據需要調整 */
    overflow: hidden;
    /* z-index: -10; */
}

.select {
    position: fixed;
    top: 9%;
    right: 1.5%;
    z-index: 99;
}

.step-fade-enter-active,
.step-fade-leave-active {
    transition: opacity 0.5s;
}

.step-fade-enter,
.step-fade-leave-to {
    opacity: 0;
}
</style>