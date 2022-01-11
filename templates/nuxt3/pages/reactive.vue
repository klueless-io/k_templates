<template>
  <NuxtLayout name="default">
    <template #header>{{titleize dom.page_name}}</template>

    <input type="text" />
    <div class="w-full max-w-xs">
      <form @submit.prevent class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <div class="mb-4">
          <label
            class="block text-gray-700 text-sm font-bold mb-2"
            for="{{dom.main_key}}">
            {{titleize dom.main_key}}
          </label>
          <input
            class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
            id="{{dom.main_key}}"
            type="text"
            v-model="model.{{lamel dom.main_key}}"
            @keyup.enter="add{{camel dom.main_key}}"
            placeholder="{{titleize dom.main_key}}">
        </div>
      </form>
    </div>

    <ul class="list-disc">
      <li v-for="item in model.items" :key="item.id">
        \{{item.title}}
      </li>
    </ul>
  </NuxtLayout>
</template>

<script setup lang="ts">
import { ref, reactive } from "vue"

const add{{camel dom.main_key}} = () => {
  model.items.push({
    id: model.items.length + 1,
    title: model.{{lamel dom.main_key}},
    completed: false,
  })
  model.{{lamel dom.main_key}} = ''
}

const model = reactive({
    {{lamel dom.main_key}}: '',
    items: [{
      id: 1,
      title: 'Title 1',
      completed: false
    }]
  })
</script>

<style>

</style>