<template>
    <div ref="chartRef" class="chart-container"></div>
</template>
  
<script setup>
import * as echarts from 'echarts/core';
import {
    TitleComponent,
    ToolboxComponent,
    TooltipComponent,
    GridComponent,
    VisualMapComponent,
    MarkAreaComponent,
    LegendComponent
} from 'echarts/components';
import { LineChart } from 'echarts/charts';
import { UniversalTransition } from 'echarts/features';
import { CanvasRenderer } from 'echarts/renderers';

// 使用相關模組
echarts.use([
    TitleComponent,
    ToolboxComponent,
    TooltipComponent,
    GridComponent,
    VisualMapComponent,
    MarkAreaComponent,
    LegendComponent,
    LineChart,
    CanvasRenderer,
    UniversalTransition
]);

import { onMounted, ref } from 'vue';

const chartRef = ref(null);

onMounted(() => {
    if (chartRef.value) {
        const myChart = echarts.init(chartRef.value);
        const option = {
            // title: {
            //     text: '過去銷售額及未來預測',
            // },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross'
                }
            },
            toolbox: {
                show: true,
                feature: {
                    saveAsImage: {}
                }
            },
            xAxis: {
                type: 'category',
                data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
            },
            yAxis: {
                type: 'value',
                axisPointer: {
                    snap: true
                }
            },
            legend: {  // 新增的 legend 配置
                data: ['Sales', 'Forcast'],
            },
            series: [
                {
                    name: 'Forcast',
                    data: [150, 230, 224, 218, 135, 147, 260],
                    type: 'line',
                    color: 'rgba(255, 165, 0, 1)'
                },
                {
                    name: 'Sales',
                    data: [150, 230, 224, 218],
                    type: 'line',
                    color: 'rgba(0, 128, 255, 1)'
                }
            ],
            grid: {
                left: 50,
                top: 10,
                right: 50,
                bottom: 50
            }
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
}
</style>