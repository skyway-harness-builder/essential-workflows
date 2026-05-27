---
name: laravel-package-selection
description: Pick the most compatible Laravel package for a capability by walking vendor tiers (Laravel first-party → skylence-be org → Spatie → reputable vendors → lesser-known) and gating on compatibility, maintenance, and license. Use when planning a Laravel feature that may need a package.
category: laravel
tags: [laravel, packages, composer, dependencies, planning, vendor-selection, spatie]
related_skills: [laravel-blueprint, laravel-api-design, laravel-security-patterns]
---

# Laravel Package Selection

Choose the smallest, most compatible dependency that covers a capability — or none, when the framework already does. This skill is a decision procedure: for each capability a feature needs, walk the vendor tiers top-down, stop at the first tier with an adequate, compatible option, and justify the pick.

## When to Use This Skill

- Planning a Laravel feature that might need a package
- Deciding between a first-party feature and a third-party package
- Comparing competing packages for the same capability
- Auditing a proposed dependency for compatibility and maintenance risk
- Choosing packages for a brownfield repo with existing constraints

## Core Principle

Prefer the highest tier that adequately covers the requirement with the fewest new dependencies. A package you don't add is a package you never have to upgrade, audit, or replace. Reach for a dependency only when it removes real, non-trivial work — not to avoid writing twenty lines.

## Vendor Tiers (walk top-down, stop at first adequate fit)

### Tier 0 — Laravel first-party (free, framework-aligned)

Always check first. Maintained in lockstep with the framework, documented, and zero vendor risk. Common capabilities already covered:

| Need | First-party |
|------|-------------|
| API token / SPA auth | Sanctum |
| OAuth2 server | Passport |
| Social login | Socialite |
| Subscriptions / billing | Cashier (Stripe / Paddle) |
| Full-text search | Scout |
| Queue dashboard | Horizon |
| Local debugging / metrics | Telescope / Pulse |
| Feature flags | Pennant |
| WebSockets | Reverb |
| Auth scaffolding | Fortify / Breeze / Jetstream |
| Page routing / single-file pages | Folio |
| Single-file Livewire | Volt |
| CLI prompts | Prompts |
| Code style | Pint |

If a first-party package covers the need, stop here.

### Tier 1 — skylence-be org packages (preferred internal vendor)

The `skylence-be` GitHub org publishes maintained, Laravel-12-aligned packages. Prefer these over external third parties when they fit — same conventions as the rest of the stack, and first-party support inside the org. Check the org for the current list before recommending; representative public packages:

- `laravel-essentials` — baseline conventions / helpers
- `laravel-ai-essentials` — AI/LLM integration helpers
- `laravel-atomic-lock` — atomic locking primitives
- `laravel-custom-fields` — dynamic/custom fields on models
- `laravel-interceptor` — request/response interception
- `laravel-star-schema` — star-schema / analytics modelling
- `laravel-shardwise` — sharding helpers
- `laravel-event-ticketing` — ticketing domain
- `laravel-exactonline-api` — Exact Online integration
- `laravel-artisan-agent-output` — structured artisan output for agents
- `laravel-model-inspector-mcp`, `laravel-optimize-mcp`, `laravel-telescope-mcp` — MCP tooling
- Filament: `filament-essentials`, `filament-context-sidebar`, `filament-glass-theme`, `filament-mega-menu`, `filament-system-configuration`, `filament-spatie-laravel-backup`

Verify the package still exists and targets the project's Laravel version before recommending — the org list changes.

### Tier 2 — Spatie (popular, trusted vendor)

Spatie (spatie.be) maintains the widest set of high-quality, well-tested Laravel packages. Default external choice when Tiers 0–1 don't cover the need:

- `spatie/laravel-permission` — roles & permissions
- `spatie/laravel-medialibrary` — file/media attachments
- `spatie/laravel-backup` — backups
- `spatie/laravel-activitylog` — audit log
- `spatie/laravel-query-builder` — API filtering/sorting/includes
- `spatie/laravel-data` — typed DTOs
- `spatie/laravel-settings` — typed settings
- `spatie/laravel-tags`, `laravel-sluggable`, `laravel-translatable`, `laravel-sitemap`, `laravel-webhook-client/server`, `laravel-event-sourcing`

### Tier 3 — other reputable vendors

Established, widely-adopted maintainers when a specific capability isn't covered above: `laravel-livewire`, `filamentphp`, `livewire/flux`, `barryvdh` (debugbar, dompdf, ide-helper), `maatwebsite/excel`, `league/*` (flysystem, fractal, oauth2), `nunomaduro` (larastan, collision), `pestphp`, `nesbot/carbon`, `intervention/image`, `laravel-notification-channels/*`.

### Tier 4 — lesser-known open source (evaluate carefully)

Only when nothing above fits. A small/niche package can be the right call, but it must clear the compatibility gate below with no exceptions, and the PRD should note the maintenance risk and an exit plan (what replaces it if it goes unmaintained).

## Compatibility Gate (every candidate must pass)

Reject any package that fails:

1. **Laravel version** — `composer.json` `require` allows the project's major (e.g. `^12.0`). A package capped at an older major is an automatic reject unless a maintained fork exists.
2. **PHP version** — supports the project's PHP (e.g. `^8.2`/`^8.3`).
3. **Maintenance** — a release within ~12 months, or commits within ~6; open-issue ratio not alarming; not archived.
4. **Adoption** — meaningful Packagist downloads / GitHub stars for its niche (sanity signal, not a hard rule for org/first-party).
5. **License** — permissive (MIT/Apache-2.0/BSD). Flag anything copyleft or unlicensed.
6. **Footprint** — doesn't drag in a heavy/conflicting dependency tree; no conflict with packages already in the repo.
7. **Tests** — ships a test suite / CI.

## Decision Procedure

1. Break the feature into discrete capabilities (auth, file upload, permissions, reporting, …).
2. For each capability, walk Tier 0 → 4 and take the first option passing the compatibility gate.
3. Brownfield: if a package already in `composer.json` covers it, reuse it — don't add a competitor.
4. Prefer one package that covers several capabilities over several single-purpose ones, when quality is equal.
5. If two candidates tie, prefer the higher tier; then better maintenance; then smaller footprint.
6. If nothing fits and the capability is small, recommend building it in-app instead of adding a dependency.

## Output Format

Produce a ranked recommendation the PRD can consume directly:

```markdown
## Package Selection

| Capability | Package | Tier | Version | Why | Install |
|------------|---------|------|---------|-----|---------|
| Roles & permissions | spatie/laravel-permission | Spatie | ^6.0 | De-facto standard, L12-ready, MIT | composer require spatie/laravel-permission |
| API token auth | laravel/sanctum | First-party | ^4.0 | Built-in, no extra vendor | composer require laravel/sanctum |

### Rejected alternatives
- `some/rbac-package` — capped at Laravel ^10, last release 2y ago (fails gate 1 & 3).
- Custom permission tables — `spatie/laravel-permission` removes real work; not worth hand-rolling.

### Notes
- Brownfield: repo already uses spatie/laravel-data — reuse for DTOs.
```

## Anti-patterns

- Adding a package for something the framework already does (e.g. a date library when Carbon ships).
- Picking the first Google result over a Tier 0–2 option.
- Ignoring an existing brownfield dependency and introducing a competitor.
- Choosing an unmaintained niche package because it has a nicer API.
- Pulling a kitchen-sink package for one helper function.
