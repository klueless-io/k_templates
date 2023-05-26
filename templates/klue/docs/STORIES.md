# {{titleize microapp.settings.application}}

> {{safe microapp.settings.description}}

{{main_story}}

## Development radar

{{#if stories.current}}
### Stories next on list

{{#each stories.current}}
{{this.story}}

{{#each this.tasks}}- {{this}}
{{/each}}

{{/each}}
{{/if}}

{{#if tasks.current}}
### Tasks next on list

{{#each tasks.current}}
{{this.story}}

{{#each this.tasks}}- {{{this}}}
{{/each}}

{{/each}}
{{/if}}

## Stories and tasks

{{#if stories.done}}

### Stories - completed

{{#each stories.done}}
{{this.story}}

{{#each this.tasks}}- {{{this}}}
{{/each}}

{{/each}}

{{/if}}

{{#if tasks.done}}

### Tasks - completed

{{#each tasks.done}}
{{this.story}}

{{#each this.tasks}}- {{this}}
{{/each}}

{{/each}}

{{/if}}
