# K-Templates

> Set of common code generation templates used by KlueLess.io


## Templates

Templates are used for generating code for target applications and systems

## Definitions

Definitions are similar to templates, except they are used when generating builders and directors

## Data Dictionary

- `template`    - Templates are used for generating code for target applications and systems
- `definition`  - Definitions are similar to templates, except they are used when generating builders and directors
- `builder`     - A builder is used to construct information for code generation. Builder follows the builder pattern.
- `director`    - A director (aka DSL) uses a builder with a domain specific language to help construct code or other artefact. Definition is a part of the builder pattern.
- `channel`     - A channel is what path in the genration process we on, are we generating builders, code, data, documentation, or something else.


1. Startup/Setup Ruby/C#/Python/Tailwind/Mixins
2. Bootstrap/Blueprint
3. Gem Pattern Generator of (Dir/Bldr or Factory or Prototype etc)
4. Use Gem Factory Pattern Generator 
5. Use Gem Builder Pattern Generator
6. Use ...

I see it important to stick to the naming conventions in the nomenclature we decide: eg never generate generators and never build generators but you can generate builders. # k_templates

