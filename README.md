# agent-stack

> A curated, tested skill-set & MCP configuration for building production web apps (SaaS/SPA) with AI coding agents — optimized for **Vercel + Cloudflare Workers**.

Instead of hunting skills one by one, this repo gives you a **battle-tested manifest**: every skill here was installed, used, and verified in a real workflow before being added.

## What's inside

| Layer | Highlights |
|---|---|
| **Planning** | `to-spec`, `to-tickets`, `grill-me`, `wizard`, `domain-modeling`, `research` (mattpocock) |
| **Frontend** | `frontend-design` (Anthropic, 1M+ installs), `impeccable`, `ui-taste`, `vercel-react-best-practices`, `tailwind-v4-shadcn`, `accessibility`, full animation set (emilkowalski + hyperframes) |
| **Backend** | `api-and-interface-design`, `nodejs-backend-patterns`, `better-auth`, `neon-postgres`, Cloudflare official set (`wrangler`, `workers-best-practices`, `durable-objects`) |
| **Testing** | `tdd`, `vitest` (antfu), `playwright-cli` (Microsoft), `webapp-testing`, `e2e-testing-patterns` |
| **Deploy** | `deploy-to-vercel`, `vercel-optimize`, `wrangler` |
| **MCP** | `context7` (docs), `shadcn` (component registry), `chrome-devtools` (live inspection), `serena` (semantic code search) |

Full manifest: [`skills.json`](skills.json) · Presets: [`presets/presets.json`](presets/presets.json) · MCP config: [`mcp.json`](mcp.json)

## Quick start

Requirements: Node.js 18+, `npx`, `python3`.

```bash
git clone https://github.com/YOUR_USERNAME/agent-stack.git
cd agent-stack

# Preview what will be installed
DRY_RUN=1 ./install.sh

# Install everything (~90 skills, global)
./install.sh

# Or just one layer
./install.sh frontend
./install.sh backend testing
```

Skills install globally via [skills.sh](https://skills.sh) (`npx skills add -g`) and are symlinked into every detected agent (Claude Code, Cursor, Codex, Hermes Agent, and 20+ more).

## MCP setup

Copy the `mcpServers` block from [`mcp.json`](mcp.json) into your agent's config:

- **Hermes Agent**: `hermes mcp add context7 --url https://mcp.context7.com/mcp` (etc.)
- **Claude Code**: `claude mcp add-json context7 '{"url": "https://mcp.context7.com/mcp"}'`
- **Cursor / VS Code**: paste into MCP settings

| MCP | Purpose |
|---|---|
| `context7` | Version-current library docs (React, Next, Tailwind, Drizzle…) |
| `shadcn` | Browse & install real shadcn/ui registry components |
| `chrome-devtools` | Live browser inspection: DOM, console, network, perf traces |
| `serena` | Semantic code search & navigation for large codebases |

## Philosophy

- **Curated, not dumped** — only skills that survived real use. Quality over quantity.
- **Manifest over fork** — we point to upstream sources instead of copying, so everything stays updateable (`npx skills update`).
- **Agent-agnostic** — standard formats only; works with any agent that reads skills/MCP.
- **Stack-focused** — tuned for TypeScript web apps deployed to Vercel (frontend + Neon Postgres) and/or Cloudflare Workers (API + D1/KV/R2).

## Presets

| Preset | Contents |
|---|---|
| `planning` | Idea → spec → tickets workflow |
| `frontend` | React/Next + UI/UX + animation |
| `backend` | APIs, auth, databases (Neon & D1) |
| `testing` | TDD, unit, E2E |
| `deploy` | Vercel & Cloudflare deployment |
| `writing` | Docs & prose quality |

## License

[MIT](LICENSE)
