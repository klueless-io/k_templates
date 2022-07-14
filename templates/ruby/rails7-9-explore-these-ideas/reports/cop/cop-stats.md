# {{title}}


| Violations                               | Count |
|------------------------------------------|-------|
| # of files                               | {{stats.file_count}} |
| # of violations                          | {{stats.issue_count}} |
| Violations that can be auto fixed        | {{stats.issue_auto_fix_count}} |
| Violations that to examine     | {{stats.issue_examine_count}} |
| Violations that are errors       | {{stats.issue_error_count}} |
| Violations that are fatal       | {{stats.issue_fatal_count}} |

Use `rubocop -a` to auto fix or `rubocop -A` to also auto fix but spend more time checking the results as it can get it wrong

## Violations grouped by Cop

Go to [Violation - Plan of Attack](./cop-plan-of-attack.md) to see an action plan on how to address these cops.

List of Cops ordered by count

| Cop                                                         | Count |
|-------------------------------------------------------------|-------|
{{#each group_stats}}
| {{padr ./cop 50}}          | {{./count}} |
{{/each}}
