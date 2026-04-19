# GitHub Publishing Guide

This guide covers the path from repository naming to first push.

## 1. Recommended Repository Name

- `aosp-weardrive-companion`
- `weardrive-aosp-platform`
- `weardrive-companion`

Recommendation for public credibility:
- keep the name short
- include either `aosp` or a strong project identity in the description
- avoid overly generic names like `wear-project`

## 2. Recommended Public Repository Description

Example:

`AOSP 16 platform project for a vehicle-to-wear companion experience with custom framework service, privileged app, transport simulation, media flows, and AI summary hooks.`

Actual repository URL:

[`github.com/AbdullahAbdelhakeem6484/aosp-weardrive-companion`](https://github.com/AbdullahAbdelhakeem6484/aosp-weardrive-companion)

## 3. Recommended Initial Repository Sections

Before pushing publicly, make sure the repo has:
- `README.md`
- architecture docs
- implementation guide
- command runbook
- GitHub publishing guide
- clear note that AOSP source modifications live in a separate tree

## 4. Initialize Git Locally

Run in the project root:

```bash
cd "$HOME/EmbeddedAndroid_Workspace/aosp-weardrive-companion"
git init
git branch -M main
git status
```

## 5. Create a Sensible `.gitignore`

Recommended starter entries:

```gitignore
.DS_Store
*.log
*.tmp
*.swp
demos/logs/
```

If `.gitignore` does not exist yet, create it before the first commit.

## 6. First Commit

```bash
cd "$HOME/EmbeddedAndroid_Workspace/aosp-weardrive-companion"
git add .
git status
git commit -m "Initialize AOSP WearDrive Companion planning workspace"
```

## 7. Create the GitHub Repository

You can do this in the GitHub UI or with `gh`.

### Option A: GitHub UI

Create a new repo named:
- `aosp-weardrive-companion`

Then copy the remote URL.

### Option B: GitHub CLI

If `gh` is configured:

```bash
cd "$HOME/EmbeddedAndroid_Workspace/aosp-weardrive-companion"
gh repo create aosp-weardrive-companion --public --source=. --remote=origin --push
```

Use `--private` instead of `--public` if you want to prepare it before launch.

## 8. Add Remote and Push Manually

If you created the repo in the UI:

```bash
cd "$HOME/EmbeddedAndroid_Workspace/aosp-weardrive-companion"
git remote add origin git@github.com:AbdullahAbdelhakeem6484/aosp-weardrive-companion.git
git remote -v
git push -u origin main
```

If you prefer HTTPS:

```bash
git remote add origin https://github.com/AbdullahAbdelhakeem6484/aosp-weardrive-companion.git
git push -u origin main
```

## 9. Recommended Commit Strategy

Use milestone-based commits, for example:
- `docs: add implementation and architecture guides`
- `build: add cuttlefish auto helper scripts`
- `framework: add WearDrive service skeleton`
- `app: add privileged companion skeleton`
- `transport: add mock adapter and validation hooks`

Why this helps:
- better reviewability
- cleaner demo and teaching history
- easier rollback

## 10. Recommended Branch Strategy

For a solo but serious project:
- `main` for stable, demoable state
- feature branches for active work

Examples:
- `feature/service-skeleton`
- `feature/companion-app`
- `feature/mock-transport`
- `feature/audio-summary`

## 11. What to Push Publicly

Push publicly:
- docs
- scripts
- architecture notes
- standalone prototypes
- screenshots and safe demo assets

Do not push publicly without review:
- proprietary credentials
- API keys
- private tokens
- local machine-specific secrets
- any licensed content you do not own

## 12. Suggested Public Launch Sequence

1. push planning workspace
2. push first AOSP integration notes
3. push first service skeleton milestone
4. push first app milestone
5. push first end-to-end demo milestone

This gives the repo a visible story instead of one giant dump.

## 13. Release Readiness Checklist

Before making the repo public:
- README is clean
- docs are navigable
- scripts have clear names
- no secrets are tracked
- project scope is understandable in under 2 minutes
- architecture diagram exists

## 14. Important Note About AOSP Source

This workspace is public-friendly.
Your full AOSP tree is large and should not be pushed as part of this repository.

Instead:
- keep this repo as the control plane
- document the AOSP patch locations
- later export or document patches cleanly

That keeps the repo practical, teachable, and much easier to market.
