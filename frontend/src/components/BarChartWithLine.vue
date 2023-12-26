<template>
    <div ref="chartRef" class="chart-container"></div>
</template>

<script setup>

import * as echarts from 'echarts/core';
import {
    ToolboxComponent,
    TooltipComponent,
    GridComponent,
    LegendComponent,
    TitleComponent
} from 'echarts/components';
import { BarChart, LineChart } from 'echarts/charts';
import { UniversalTransition } from 'echarts/features';
import { CanvasRenderer } from 'echarts/renderers';

echarts.use([
    ToolboxComponent,
    TooltipComponent,
    GridComponent,
    LegendComponent,
    BarChart,
    LineChart,
    CanvasRenderer,
    UniversalTransition,
    TitleComponent
]);

import { onMounted, ref } from 'vue';

const chartRef = ref(null);

const props = defineProps({
  chartData: {
    xAxisData: [],
    yAxisRev: [],
    yAxisGrowthRate: []
  }
})

onMounted(() => {
    if (chartRef.value) {
        const myChart = echarts.init(chartRef.value);

        // 讓圖表自適應容器大小
        const resizeHandler = () => {
            myChart.resize();
        };
        window.addEventListener('resize', resizeHandler)

        const option = {
            title: {
                text: "過去半年銷售總額與銷售成長",
                left: "center",
                // top: "center",
                textStyle: {
                    fontSize: 14
                }
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross',
                    crossStyle: {
                        color: '#999'
                    }
                }
            },
            toolbox: {
                feature: {
                    dataView: { show: true, readOnly: false },
                    // restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            legend: {
                data: ['Revenue', 'Growth Rate (%)'],
                top: 25 // 調整 legend 的位置
            },
            xAxis: [
                {
                    type: 'category',
                    data: props.chartData.xAxisData,
                    axisPointer: {
                        type: 'shadow'
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    name: 'Revenue',
                    // min: 0,
                    // max: 250,
                    interval: 50,
                },
                {
                    type: 'value',
                    name: 'Growth Rate (%)',
                    // min: 0,
                    // max: 25,
                    interval: 5,
                }
            ],
            series: [
                {
                    name: 'Revenue',
                    type: 'bar',
                    tooltip: {
                        valueFormatter: function (value) {
                            return '$' + value;
                        }
                    },
                    data: props.chartData.yAxisRev
                },
                {
                    name: 'Growth Rate (%)',
                    type: 'line',
                    yAxisIndex: 1,
                    tooltip: {
                        valueFormatter: function (value) {
                            return value + ' °C';
                        }
                    },
                    data: props.chartData.yAxisGrowthRate
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
    }
    // 讓圖表自適應容器大小
    return () => {
        window.removeEventListener('resize', resizeHandler);
    }
})

</script>

<style>
.chart-container {
    width: calc((100%-18%)/2);
    height: 250px;
}
</style>