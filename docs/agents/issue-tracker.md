# Issue tracker: todo.txt (tuxedo)

Issues live as entries in a standard todo.txt file at the repo root (`todo.txt`),
edited with the [tuxedo](https://github.com/webstonehq/tuxedo) terminal UI.

## Conventions

- **todo.txt format**: [Standard todo.txt](https://github.com/todotxt/todo.txt) —
  each line is a single task. Optional priority `(A)`, `(B)`, `(C)` at the start.
  Projects `+project`, contexts `@context`, and key:value tags (e.g. `due:YYYY-MM-DD`)
  are supported.

- **Create an issue**: Append a line to `todo.txt`. Use `@triage` context and the
  appropriate triage `@needs-*` context tag. Example:
  ```
  (A) Implement frobnicator +dotfiles @triage @needs-triage
  ```

- **Read issues**: `grep` over `todo.txt`, filtering by `@triage`, `@needs-*`, or
  `@in-progress` contexts. Lines starting with `x` are completed.

- **Update state**: Edit the relevant line to swap its `@needs-*` context
  (e.g. `@needs-triage` → `@ready-for-agent`). Completion is `x <YYYY-MM-DD>` prefix.

- **Close**: Prefix the line with `x <YYYY-MM-DD>`. Optionally move to `done.txt`
  (tuxedo supports this via the `A` key).

- **Triage labels**: Applied as `@needs-triage`, `@needs-info`, `@ready-for-agent`,
  `@ready-for-human`, `@wontfix` — see `docs/agents/triage-labels.md`.

## When a skill says "publish to the issue tracker"

Append a new line to `todo.txt` with the appropriate `@triage` and `@needs-*` contexts.

## When a skill says "fetch the relevant ticket"

Read `todo.txt` and filter by line number or a known `@context` tag.
