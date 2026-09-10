# My Little Blog

Hugo + PaperMod, bilingual (English at the root, Chinese under `/zh/`), with
Algolia search. Deployed on Vercel.

## Setup

```bash
git clone --recurse-submodules <repo>
cd MyLittleBlog
npm ci
./scripts/setup-hooks.sh
cp .env.example .env      # then fill in the Algolia admin key
```

`setup-hooks.sh` installs the pre-commit hooks and registers the git-secrets
patterns. git-secrets keeps its patterns in `.git/config`, which is not shared
between clones, so they live in `.gitsecrets` / `.gitsecrets-allowed` and are
loaded from that script. Run it once per clone.

## Daily use

```bash
npm run dev        # preview drafts
npm run dev:prod   # also emit SEO tags (OpenGraph, JSON-LD, GA)
npm run build      # production build into public/
npm run deploy     # build, then push the Algolia index
```

These wrap Hugo so that `.env` is sourced first. Running `hugo server` directly
still works, but without the Algolia variables the search page renders its
"not configured" notice.

SEO tags and analytics are gated behind `env: production`, so the default
development server omits them. Check them with the second command.

## Writing

Posts live under `content/<section>/`. The directory becomes the URL section.

```
content/tech/post-name.md      -> /tech/post-name/
content/tech/post-name.zh.md   -> /zh/tech/post-name/
```

Org files are written in Emacs and exported to Markdown with ox-hugo; Hugo only
ever sees Markdown.

## Deploying

Vercel builds `./build.sh` on every push to `main`. That script pins the Hugo
version, builds the site, and pushes the Algolia index — but only when
`VERCEL_ENV=production`, so preview deployments cannot overwrite the live index.

The index can also be pushed by hand:

```bash
hugo --minify
node --env-file=.env scripts/algolia-push.mjs
```

## Secrets

| Value | Where it lives | Public? |
|-------|----------------|---------|
| Algolia app ID | `.env`, Vercel env vars | yes — ships in the HTML |
| Algolia search-only key | `.env`, Vercel env vars | yes — ships in the HTML |
| Algolia admin key | `.env`, Vercel env vars | **no** |

The first two are public by design; they are kept out of `hugo.yaml` only so the
repository holds no credential-shaped strings and the scanners need no
exceptions. Hugo picks them up through `HUGO_PARAMS_*` overrides, so they must
also be set for Vercel's Preview environment — otherwise preview builds render
an inert search page.

Three hooks guard against committing the admin key: TruffleHog (verified
credential detection), git-secrets (pattern matching), and a check that refuses
a staged `.env`. Verify them with `pre-commit run --all-files`.
