# API Reference Overview

This section is the auto-generated source-level reference for the
CUBRID database engine. Every page below this one is produced from
Doxygen XML at build time and reflects the state of the
[CUBRID `develop` branch](https://github.com/CUBRID/cubrid/tree/develop)
at the most recent rebuild.

## Where to start

If you know what you're looking for, use the search box (top right).
Otherwise pick the entry point that matches your task:

| If you want to&hellip; | Start here |
| --- | --- |
| Browse the source tree as on disk | [Files](files.md) |
| Find a C++ class or struct | [Classes](classes.md) |
| Inspect a namespace (`cubrid::*`, etc.) | [Namespaces](namespaces.md) |
| See how classes inherit from each other | [Class Hierarchy](hierarchy.md) |
| Look at logically grouped APIs (Doxygen `@defgroup`) | [Modules](modules.md) |
| Read free-form design notes (`@page`) | [Related Pages](pages.md) |
| See annotated usage examples (`@example`) | [Examples](examples.md) |

## What is covered

The reference indexes the CUBRID server-side tree under
`cubrid/src/`. The following subtrees are intentionally excluded
because they are either client interfaces published as separate
products or out-of-process tooling:

- `src/cci/`, `src/jdbc/`, `src/odbc/`, `src/oledb/` &mdash; client
  drivers
- `src/cm_common/`, `src/tools/`, `src/win_tools/` &mdash; admin and
  management tools

Generated parser/scanner output (`*.tab.*`, `lex.yy.*`, `*_lex.*`,
`*_generated.*`) is also filtered out.

## How the index is built

```text
CUBRID source  →  Doxygen (XML)  →  mkdoxy  →  MkDocs Material  →  HTML
```

- **Doxygen** parses the C and C++ sources with macro expansion
  enabled and a curated set of `PREDEFINED` macros that neutralise
  GCC attributes, `STATIC_INLINE`/`INLINE`/`EXPORT_IMPORT` markers,
  and exposes the `SERVER_MODE`, `CS_MODE`, and `SA_MODE` build
  variants.
- **mkdoxy** walks the resulting XML and emits Markdown stubs for
  every symbol.
- **MkDocs Material** renders those stubs together with the
  hand-written pages under `docs/` into a single static site.

## Limitations

- Symbols whose first-character is non-alphabetic (`$accept` and
  similar yacc internals, mangled names, GCC `__builtin_*`) are
  filtered out at the Doxygen layer to keep mkdoxy's alphabetic
  index happy.
- yacc (`.y`) and lex (`.l`) grammar files are **not** indexed.
  Doxygen cannot meaningfully document grammar rules; the C action
  blocks that ship with them are usually exercised via the headers
  the grammar produces.
- Static-only symbols inside `.c` files are indexed
  (`EXTRACT_STATIC = YES`), so the surface area is large. Prefer
  search over manual browsing.

## Reporting problems

- **Missing or mis-rendered symbols** &mdash; open an issue on
  [hgryoo/cubrid-doxygen](https://github.com/hgryoo/cubrid-doxygen/issues).
  Please include the source file, the symbol name, and what you
  expected to see.
- **Out-of-date content** &mdash; the site rebuilds every Sunday at
  18:00 UTC. To trigger an early rebuild, run the
  "Build & Deploy Docs" workflow from the
  [Actions tab](https://github.com/hgryoo/cubrid-doxygen/actions).
- **Wrong documentation in source comments** &mdash; open the issue
  upstream against
  [CUBRID/cubrid](https://github.com/CUBRID/cubrid/issues).
