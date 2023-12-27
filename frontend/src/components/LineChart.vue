<template>
    <div ref="chartRef" class="chart-container"></div>
</template>

<script setup>
import * as echarts from 'echarts/core';
import { onMounted, ref, watch } from 'vue';
import { TitleComponent, ToolboxComponent, TooltipComponent, GridComponent, VisualMapComponent, MarkAreaComponent, LegendComponent } from 'echarts/components';
import { LineChart } from 'echarts/charts';
import { CanvasRenderer } from 'echarts/renderers';
import { UniversalTransition } from 'echarts/features';

const props = defineProps({
  chartData: {
    type: Object,
    default: () => ({
      xAxisData: [],
      yAxisSales: [],
      yAxisForcast: []
    })
  }
});

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

const chartRef = ref(null);

const createChart = () => {
  if (chartRef.value) {
    const myChart = echarts.init(chartRef.value);

    const option = {
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
        axisPointer: {
          snap: true
        }
      },
      legend: {
        data: ['Sales', 'Forcast'],
      },
      series: [
        {
          name: 'Forcast',
          data: props.chartData.yAxisForcast,
          type: 'line',
          color: 'rgba(255, 165, 0, 1)'
        },
        {
          name: 'Sales',
          data: props.chartData.yAxisSales,
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
    return myChart;
  }
};

let myChart = null;

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
    width: calc(100%-18%);
    height: 250px;
}
</style>
