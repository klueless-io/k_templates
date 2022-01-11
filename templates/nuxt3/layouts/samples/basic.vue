<template>
  <div class="flex flex-col w-full h-screen overflow-hidden bg-green-50">
    <Menu />
    <header class="w-full h-16 bg-green-500 mb-5">
      <nav class="flex items-center justify-center w-full h-full text-center text-black">
        <h2 class="text-2xl font-bold text-white">
          <slot name="header">
            <span>Basic Layout</span>
          </slot>
        </h2>
      </nav>
    </header>
    <main class="flex-grow w-full h-full p-4 mx-auto max-w-7xl">
      <slot />
    </main>
    <slot name="footer">
      <footer class="flex items-center justify-center w-full h-16 text-black">
          <p class="text-gray-700">
            Printspeak &copy; \{{ new Date().getFullYear() }}
          </p>
      </footer>
    </slot>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
export default defineComponent({
  computed: {
    header() {
      return this.$slots.header
    }
  }
})
</script>