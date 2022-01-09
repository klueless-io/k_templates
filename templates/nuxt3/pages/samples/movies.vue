<template>
  <NuxtLayout name="page">
    <template #header>List of Movies</template>
    <div>
      <form class="form" @submit.prevent="movieSearch">
        <input type="text" v-model="searchText" />
        <button>Search For TV Shows</button>
      </form>
      <div class="stuff">
        <div v-for="show in myData">
          <a :href="`/movie/${show.show?.id}`">
            <img :src="show.show?.image?.medium" alt="" />
            <h1>\{{show.show.name}}</h1>
          </a>
        </div>
      </div>
    </div>
  </NuxtLayout>
</template>

<script setup lang="ts">
import { ref } from "vue";
const searchText = ref("");
const myData = ref([]) as any;

async function movieSearch() {
  const data = await fetch(`/api/movies?search=${searchText.value}`);
  const json = await data.json();
  console.log("data.value", json);
  myData.value = json;
}

</script>

<style>
.stuff {
  margin-top: 50px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;
  /* flex-direction: column; */
  gap: 10px;
}
.form {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 100px;
}
</style>