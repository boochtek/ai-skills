---
name: html
description: HTML and CSS guidelines. Use when generating HTML output (reports, briefings, docs) or writing HTML/CSS in application code. Covers Markdown-first workflow via md2html and modern HTML/CSS feature preferences.
---

# HTML & CSS

## Markdown-First Output

When generating HTML output (briefings, reports, documentation, etc.), prefer writing **Markdown first**, then converting to HTML. This saves tokens and keeps content editable.

Use `md2html` (`~/.local/bin/md2html`) for conversion. It's a Bun wrapper around markdown-it with extensions for `==highlights==`, footnotes, task lists, and heading anchors.

```bash
md2html input.md -o output.html   # Convert to HTML file
md2html input.md --open            # Open directly in browser
md2html input.md --css style.css   # Use custom CSS
cat input.md | md2html             # Read from stdin
```

Use embedded HTML within Markdown only when needed (images with sizing, styled callout boxes, complex layouts).

## Modern HTML & CSS

Use modern features. Target current browser versions (evergreen browsers).

### HTML

- Semantic elements: `<article>`, `<section>`, `<nav>`, `<aside>`, `<header>`, `<footer>`, `<main>`
- `<dialog>` for modals
- `<details>`/`<summary>` for disclosure widgets
- `<template>` for client-side templating
- Native form validation attributes (`required`, `pattern`, `type="email"`, etc.)
- `loading="lazy"` on images and iframes
- `<picture>` and `srcset` for responsive images

### CSS

- Custom properties (`--var`) over preprocessor variables
- `container` queries for component-level responsiveness
- `grid` and `subgrid` for layout
- `flexbox` for one-dimensional alignment
- `has()`, `is()`, `where()`, `not()` selectors
- `color-mix()`, `oklch()` for color
- `@layer` for cascade management
- `aspect-ratio`, `gap`, `clamp()` for sizing
- Logical properties (`inline-start`, `block-end`) over directional (`left`, `right`)
- `prefers-color-scheme`, `prefers-reduced-motion` media queries
