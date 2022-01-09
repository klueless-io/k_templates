<template>
  <div>
    <div class="mt-2 bg-blue-600 font-semibold text-4xl p-4 text-white">
      <div class="pb-2">Say</div>
      <HelloWorld v-bind="{ label: 'Hello Vue3/Nuxt3 World' }" />
    </div>
    <div class="mx-4 grid grid-cols-3 gap-2 bg-blue-200 p-2">
      <!-- First sub div is not for rounding-->
      <div class="rounded-none bg-blue-400 w-48 h-12">rounded-none</div>
      <div class="rounded bg-blue-400 w-48 h-12">rounded</div>
      <div class="rounded-sm bg-blue-400 w-48 h-12">rounded-sm</div>
      <div class="rounded-md bg-blue-400 w-48 h-12">rounded-md</div>
      <div class="rounded-lg bg-blue-400 w-48 h-12">rounded-lg</div>
      <div class="rounded-xl bg-blue-400 w-48 h-12">rounded-xl</div>
    </div>
    <h2>\{{data}}</h2>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
  layout: 'page',
})
</script>

<script lang="ts" setup>
const { data } = await useFetch('/api/hello')
</script>

<style>
body {
  @apply bg-blue-500;
}
</style>
