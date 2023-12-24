<template>
  <div>
    <Bar />
    <router-view></router-view>
  </div>
</template>

<script>
import Bar from '@/components/Bar.vue'

export default {
  name: 'App',
  components: {
    Bar
  }
}
</script>
<style>
</style>
