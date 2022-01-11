
<template>
    <ul class="main-nav flex">
    <li v-for="item in navLinks" class="mr-6">
      <NuxtLink :to="item.url">\{{item.label}}</NuxtLink>
    </li>
    <li>
      <input type="color" v-model="userColor" /> {{userColor}}
    </li>
  </ul>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const navLinks = ref([
  {
    label: 'Home',
    url: '/'
  },
  {
    label: 'Counter',
    url: '/counter'
  },
  {
    label: 'Count A Lot',
    url: '/counter-alot'
  },
  {
    label: 'Movies',
    url: '/movies'
  },
  {
    label: 'ToDo',
    url: '/todo'
  }
])

const userColor = ref('#ffffff')
</script>

<style>
.main-nav .router-link-active {
  background-color: v-bind(userColor);
}
</style>
