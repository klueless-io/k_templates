# {{titleize microapp.settings.application}}

> {{safe microapp.settings.description}}

{{main_story}}

## Usage

{{#each usage.detailed}}
### {{titleize this.group}}

{{this.application_description}}

{{#each this.examples}}
{{#if ./name}}
#### {{./name}}
{{/if}}
{{#if ./application_description}}{{safe ./application_description}}{{/if}}

{{#if ./ruby}}
```ruby
{{safe ./ruby}}```
{{/if}}
{{#if ./code_block}}
{{#with ./code_block}}
```{{./format}}
{{safe ./content}}```
{{/with}}
{{/if}}
{{#if ./image}}![]({{image}}){{/if}}

{{/each}}

{{/each}}
