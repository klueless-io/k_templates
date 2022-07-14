# {{title}}

I would suggest that we look at each section in the plan of attack and do a PR for each group of violations.

I have included the commands that you can run on a case by case basis to give you a list of files that match the cop, you can just run the command from `shell` and click on the output link to go the particular issue.

## What Cops should be skipped

Sometimes a Cop needs to be left alone for a particular piece of code, this is especially true for `Metrics/AbcSize`, `Metrics/CyclomaticComplexity` and `Metrics/PerceivedComplexity` as these issues require refactoring and a refactor is predicated on the existence of unit tests which we may be lacking.

## Ignore a Cop - Helpful VSCode code snippet

So if you want to wrap a section of code in a cop then do these steps.

- Open `Code -> UserSnippets`
- Open `ruby.json`
- Add

```json
"rubocop": {
  "prefix": "cop",
  "body": [
    "# rubocop:disable ${0}",
    "${TM_SELECTED_TEXT}",
    "# rubocop:enable ${0}"
  ],
  "description": "create robocop enable/disable around selected code"
},
```

```bash
# copy the cop name into clipboard, press ctrl|cmd+c on this text
Metrics/AbcSize

# Then select a section of code from beginning to end using your mouse
# then type snippet keyword
cop
# and press enter

# press ctrl|cmd+v to inject cop from clipboard
```

## Violations overview

| Violations                               | Count |
|------------------------------------------|-------|
| # of files                               | {{stats.file_count}} |
| # of violations                          | {{stats.issue_count}} |
| Violations that can be auto fixed        | {{stats.issue_auto_fix_count}} |
| Violations that to examine     | {{stats.issue_examine_count}} |
| Violations that are errors       | {{stats.issue_error_count}} |
| Violations that are fatal       | {{stats.issue_fatal_count}} |

## PR-QUICK-WIN

> List of violations where the count is small (1-5)

The first PR is to get rid of a bunch of infrequent violations.

You can either fix them directly or wrap in `cop exclusion` if the work involved would require refactoring. see `VSCode snippet above`.

### Run this command to see the affected files

```
rubocop --only {{#each group_stats_auto_fix_low5}}{{./cop}}{{#if @last}}{{else}},{{/if}}{{/each}}
```

The command will result in the following:

```bash
520 files inspected, 152 offenses detected, 110 offenses auto-correctable
```

If you want to speed up your fixes then re-run the command with the `-a` flag which will automatically fix 110 of the issues.

At this stage, you may decide to split the PR-AutoFix into PR-ManualFix where you would do the manually changes.

### List of violations - quick wins

| Files | Cop                                                         | Issues |
|-------|-------------------------------------------------------------|--------|
{{#each group_stats_auto_fix_low5}}
| {{./file_count}} | {{padr ./cop 50}}          | {{./count}} |
{{/each}}

## 30 AUTOFIX PRs

> Work through the top :autofix violations

The next 30 PR's are similar to the `Double Quote` PR worked on recently.

I suggest that each Cop be tackled one at a time as there will be a lot of files updated, I've ordered this list by the number of files affected.

I think it is best that we merge to master and push into production before moving onto the next PR, this means we would not do more then 1 PR a day, but we can gradually clean up a lot of code and improve coding techniques along the way.

This is the list of Cops can also be fixed automatically using `rubocop -a`

### List of violations - Ordered by files affected

| # | Files | Cop                                                         | Issues | Command |
|---|-------|-------------------------------------------------------------|--------|---------|
{{#each group_stats_auto_fix_top30}}
|{{@index}} | {{./file_count}} | {{padr ./cop 50}}          | {{./count}} | ```rubocop -a --only {{./cop}}```
{{/each}}


## PR-INSPECT

> List of violations where the count is small but they must be manually checked

This PR can be done using the `rubocop -A` command, notice the capital **A**, it will autofix the code for you, but it sometimes gets things wrong so you need to investigate each change.

### Run this command to see the affected files

```
rubocop --only {{#each group_stats_examine_low5}}{{./cop}}{{#if @last}}{{else}},{{/if}}{{/each}}
```

The command will result in the following:

```bash
521 files inspected, 27 offenses detected
```

### List of violations - requires manual examination

| ID | Files | Cop                                                         | Issues | Command |
|----|-------|-------------------------------------------------------------|--------|---------|
{{#each group_stats_examine_low5}}
|{{@index}} | {{./file_count}} | {{padr ./cop 50}}          | {{./count}} | ```rubocop -A --only {{./cop}}```
{{/each}}

## 30 MANUAL PRs

> Work through the top :examination_required violations

Some of the violations in the list can be ignored, I've put a ~~strike through~~ for these items.

Most ~~strikes~~ are better dealt with using code generation for specific patterns or techniques that promote SRP.

### List of violations that require manual checking - Ordered by files affected

| # | Files | Cop                                                         | Issues | message | Command |
|---|-------|-------------------------------------------------------------|--------|---------|---------|
{{#each group_stats_examine_top30}}
|{{@index}} | {{./file_count}} | {{padr ./display/cop 50}}          | {{./count}} | {{./message}} | ```rubocop -A --only {{./cop}}```
{{/each}}
