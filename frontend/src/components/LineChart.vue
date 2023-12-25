<template>
    <div ref="chartRef" class="chart-container"></div>
</template>
  
<script setup>
import * as echarts from 'echarts/core';
import { GridComponent } from 'echarts/components';
import { LineChart } from 'echarts/charts';
import { UniversalTransition } from 'echarts/features';
import { CanvasRenderer } from 'echarts/renderers';

// 使用相關模組
echarts.use([GridComponent, LineChart, CanvasRenderer, UniversalTransition]);

import { onMounted, ref } from 'vue';

const chartRef = ref(null);

onMounted(() => {
    if (chartRef.value) {
        const myChart = echarts.init(chartRef.value);
        const option = {
            xAxis: {
                type: 'category',
                data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
            },
            yAxis: {
                type: 'value'
            },
            series: [
                {
                    data: [150, 230, 224, 218, 135, 147, 260],
                    type: 'line'
                }
            ]
        };
        myChart.setOption(option);
    }
});
</script>
  
<style>
/* CSS 样式 */
.chart-container {
    width: calc(100%-18%);
    height: 250px;
    margin-top: 0;
    padding-top: 0;
}
</style>