---
status: accepted
---

# Palette hex values stay duplicated per config, not generated from one source

Solarized Dark hex values are hand-copied across `ghostty/config`,
`starship.toml`, `nvim/lua/plugins/colorscheme.lua`,
`opencode/themes/solarized-dark.json`, and `Xresources`, each in that tool's
native format. A single palette source with a generator per tool was
considered (and reviewed during an `/improve-codebase-architecture` pass) as a
way to give colour changes locality — edit one file instead of five. It was
rejected: this repo has no build step today, and introducing one just to keep
colours in sync isn't worth trading away the current "every config is a plain,
directly-readable static file" property. Changing a colour remains an N-file
edit — see the "Theme consistency" note in `CLAUDE.md`.
