{{#each entity.columns}}
select * from {{snake this.names}}
{{/each}}