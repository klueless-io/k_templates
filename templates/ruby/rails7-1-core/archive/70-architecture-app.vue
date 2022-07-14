<template>
  <div id="app">

    <h3>{{curly-open 2}}title}}</h3>

    <ul class="list-group col-12">
      <li class="list-group-item" v-for="link in links">
        <a class="btn btn-link btn-block" v-bind:href="link.url" target="sample">{{curly-open 2}}link.title}}</a>
      </li>
    </ul>

  </div>
</template>

<script>
export default {
  data: function () {
    return {
      title: "API Samples - VUE.js",
      links: [
{{#each models}}
        { title: '{{titleize (humanize this.names)}}', url: "/api/v1/{{snake this.names}}/sample" }{{#if @last}}{{else}},{{/if}}
{{/each}}
      ]
    }
  }
}
</script>
