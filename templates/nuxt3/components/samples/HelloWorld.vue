<template>
    <div class="bg-gray-100 p-4 rounded-lg text-gray-900 relative">
        \{{label}}
        <span class="absolute animate-ping top-0 left-0 bg-red-500 rounded-full h-3 w-3"></span>
    </div>
</template>

<script lang="ts">
export default {
    props: {
        label: {
            type: String,
            requried: true
        }
    }
}
</script>