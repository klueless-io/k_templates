<template>
  <div class="flex flex-col items-center justify-center h-full space-y-4 text-xl">
    <p>Counter:</p>
    <div class="flex items-center justify-center">
      <button @click="counter--" class="px-4 py-2 font-bold text-white bg-blue-500 rounded  hover:bg-blue-700">-</button>
      <span class="mx-2">\{{ counter }}</span>
      <button @click="counter++" class="px-4 py-2 font-bold text-white bg-blue-500 rounded  hover:bg-blue-700">+</button>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";

export default defineComponent({
  setup() {
    const counter = ref(0);

    return {
      counter,
    };
  },
});
</script>
