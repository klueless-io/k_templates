<template>
  <NuxtLayout name="default">
    <template #header>List of Movies</template>
    <div>
      <h3>Movie</h3>
      <p>Finish page please</p>
      {{ $route.params }}
    </div>
  </NuxtLayout>
</template>

<script setup lang="ts">
// import { ref } from "vue";

// const movie = ref([]) as any;
// const id = this.$route.params.id;

// async function moveDetail() {
//   // test = await data.value.json();
//   const data = await fetch(`/api/movie/${id}`);
//   const json = await data.json();
//   console.log("data.value", json);
//   movie.value = json;
// }
// moveDetail()
</script>