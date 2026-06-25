# Triage Labels

The skills speak in terms of five canonical triage roles. This file maps those roles
to the actual `@context` tags used in this repo's todo.txt issue tracker.

| Role               | Tag in todo.txt    | Meaning                                  |
| ------------------ | ------------------ | ---------------------------------------- |
| `needs-triage`     | `@needs-triage`    | Maintainer needs to evaluate this issue  |
| `needs-info`       | `@needs-info`      | Waiting on reporter for more information |
| `ready-for-agent`  | `@ready-for-agent` | Fully specified, ready for an AFK agent  |
| `ready-for-human`  | `@ready-for-human` | Requires human implementation            |
| `wontfix`          | `@wontfix`         | Will not be actioned                     |

When a skill mentions a role (e.g. "apply the AFK-ready triage label"), use the
corresponding `@context` tag from this table.
