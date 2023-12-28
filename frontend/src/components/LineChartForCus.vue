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
    LegendComponent
} from 'echarts/components';
import { LineChart } from 'echarts/charts';
import { UniversalTransition } from 'echarts/features';
import { CanvasRenderer } from 'echarts/renderers';
import { onMounted, ref, watch } from 'vue';

const props = defineProps({
    chartData: {
        type: Object,
        default: () => ({
            xAxisData: [],
            yAxisInterval: []
        })
    }
})

// 使用相關模組
echarts.use([
    TitleComponent,
    ToolboxComponent,
    TooltipComponent,
    GridComponent,
    VisualMapComponent,
    LegendComponent,
    LineChart,
    CanvasRenderer,
    UniversalTransition
]);



const chartRef = ref(null);

const createChart = () => {
    if (chartRef.value) {
        const myChart = echarts.init(chartRef.value);
        const option = {
            title: {
                text: "過去半年平均購買間隔時間",
                left: "center",
                // top: "center",
                textStyle: {
                    fontSize: 14
                }
            },
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
                data: props.chartData.xAxisData
            },
            yAxis: {
                type: 'value',
                name: '平均購買間隔',
                axisPointer: {
                    snap: true
                }
            },
            legend: {
                data: ['平均購買間隔'],
                top: 25 // 調整 legend 的位置
            },
            series: [
                {
                    name: '平均購買間隔',
                    data: props.chartData.yAxisInterval,
                    type: 'line',
                    color: 'rgba(255, 165, 0, 1)',
                    tooltip: {
                        valueFormatter: function (value) {
                            return value + ' days'; //視數據修改
                        }
                    },
                }
            ],
            grid: {
                left: 50,
                top: 75,
                right: 50,
                bottom: 50
            }
        };
        myChart.setOption(option);
        return myChart
    }
};

let myChart = null
onMounted(() => {
  myChart = createChart();
});

watch(() => props.chartData, () => {
  if (myChart) {
    myChart.dispose(); // Dispose the current chart
  }
  myChart = createChart(); // Create a new chart instance
}, { deep: true });
</script>
  
<style>

.chart-container {
    width: calc((100%-18%)/2);
    height: 250px;
}
</style>