<template>
    <div class="card-container">
        <div class="div-card">
            <el-card :style="getCardStyle(-1)">
                <template #header>
                    <div class="card-header" style="text-align: center;">
                        <span>{{ props.chartData.part_no }}</span>
                    </div>
                </template>
                <div class="set-text">
                    <el-text class="text-item" size="small">需求: {{ props.chartData.quantity }}</el-text>
                    <el-text class="text-item" size="small">期限: {{ props.chartData.date }}</el-text>
                </div>
            </el-card>
        </div>
        <el-icon>
            <Right />
        </el-icon>
        <div class="div-card">
            <el-card v-for="(subItem, subIndex) in props.chartData.materials" :style="getCardStyle(subIndex)">
                <template #header>
                    <div class="card-header" style="text-align: center;">
                        <span>{{ subItem.part_no }}</span>
                    </div>
                </template>
                <div class="set-text">
                    <el-text class="text-item" size="small">需求: {{ subItem.quantity }}</el-text>
                    <el-text class="text-item" size="small">期限: {{ subItem.date }}</el-text>
                </div>
            </el-card>
        </div>
        <div class="div-card" v-if="nLevel > 2">
            <div v-for="(subItem, subIndex) in props.chartData.materials" class="group">
                <el-card v-for="(subSubItem, subSubIndex) in subItem.materials" :style="getCardStyle(subIndex)">
                    <template #header>
                        <div class="card-header" style="text-align: center;">
                            <span>{{ subSubItem.part_no }}</span>
                        </div>
                    </template>
                    <div class="set-text">
                        <el-text class="text-item" size="small">需求: {{ subSubItem.quantity }}</el-text>
                        <el-text class="text-item" size="small">期限: {{ subSubItem.date }}</el-text>
                    </div>
                </el-card>
            </div>
        </div>
    </div>
</template>
  
<script setup>
import { ref, onMounted, computed } from 'vue';

const props = defineProps({
    chartData: {
        type: Object
    }
})

console.log('props', props.chartData)

const calculateDepth = (obj) => {
    if (!obj || !Array.isArray(obj.materials)) {
        return 1; // If materials array doesn't exist or is empty, it's the first level
    }

    let maxDepth = 0;
    for (const item of obj.materials) {
        const depth = calculateDepth(item);
        if (depth > maxDepth) {
            maxDepth = depth;
        }
    }
    return maxDepth + 1;
};

const nLevel = computed(() => calculateDepth(props.chartData))
console.log('calculateDepth', calculateDepth(props.chartData))

const cardWidth = computed(() => {
    return `calc((100% - 18%) / ${nLevel.value})`;
})

const getCardStyle = (index) => {
    // Define logic to set different border colors based on subIndex value
    if (index === 0) {
        return {
            'border': '1.5px solid #4fa0cb',
            'margin': '3px',
        };
    } else if (index === 1) {
        return {
            'border': '1.5px solid #ffae00',
            'margin': '3px',
        };
    } else if (index === 2) {
        return {
            'border': '1.5px solid #76de35',
            'margin': '3px',
        };
    } else {
        return {
            'border': '1.5px solid #7e7e7e',
            'margin': '3px',
        };
    }

}


</script>
  
<style scoped>
.card-container {
    background-color: var(--vt-c-white-soft);
    display: flex;
    position: fixed;
    top: 7%;
    left: 18%;
    right: 0;
    width: calc(100% - 18%);
    height: 55%;
    min-height: 250px;
    justify-content: center;
    /* 將內容水平置中*/
    flex-direction: row-reverse;
    align-items: center;
}

.div-card {
    width: var(--cardWidth);
    /* margin: 1% 2%; */
}

.card-header {
    padding: 0px;
    margin: 0px;
}

:deep(.el-card__header) {
    padding: 2px 6px;
}

:deep(.el-card__body) {
    padding: 2px 6px;
}

/* .el-card{
 border: 2px; 
} */

.group {
    margin: 7px;
    padding: 4px;
}

.set-text {
    display: flex;
    flex-direction: column;
    align-items: left;
}

.text-item {
    display: block;
    align-self: flex-start;
    /* 子项在侧轴上向左对齐 */
}
</style>
  