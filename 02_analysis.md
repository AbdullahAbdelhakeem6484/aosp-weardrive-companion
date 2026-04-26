# 02_analysis.md

Feature-by-feature analysis for MVP completion.

## Global Constraints

- Do not modify AOSP source directly without explicit approval.
- Keep implementation orchestration in this repository.
- Validate each feature before moving forward.

## Feature 01 Analysis: Safety Rules and Workspace Isolation

Problem:
- High risk of path confusion and accidental writes.

Current state:
- Implemented and validated.

Concepts:
- Environment isolation
- Safety gate before operations
- Reproducible setup

OEM notes:
- This is mandatory for auditability and onboarding.

## Feature 02 Analysis: Project Validation Script

Problem:
- Manual checks are error-prone and inconsistent.

What we need:
- Single command to verify repository health.

Concepts:
- Shift-left validation
- Deterministic preflight checks
- Fast feedback loop

Risks:
- False positives if script is too strict.

Mitigation:
- Keep checks practical and clearly messaged.

## Feature 03 Analysis: Smoke Test Runner

Problem:
- No quick confidence check after changes.

What we need:
- 30-90 second smoke test script.

Concepts:
- Smoke testing vs full testing
- Operational confidence gates

Risks:
- Overloading smoke tests with slow checks.

Mitigation:
- Keep smoke tests minimal and fast.

## Feature 04 Analysis: AOSP16 Environment Verification

Problem:
- Subtle environment drift can break builds.

What we need:
- Script to verify tools, paths, and target.

Concepts:
- Environment determinism
- Build reproducibility

Risks:
- Tool path differences across systems.

Mitigation:
- Check required essentials only.

## Feature 05 Analysis: Build Workflow Cleanup

Problem:
- Inconsistent build entry points increase confusion.

What we need:
- One clear build flow and script conventions.

Concepts:
- Build orchestration
- Script idempotency

Risks:
- Breaking existing working path.

Mitigation:
- Refactor incrementally with validation.

## Feature 06 Analysis: Cuttlefish Launch Workflow Validation

Problem:
- “Launch succeeded” does not always mean usable runtime.

What we need:
- post-launch checks for boot completion and device readiness.

Concepts:
- Runtime readiness
- Virtual device operational checks

Risks:
- Flaky checks due to timing.

Mitigation:
- Add retry loops with clear timeout.

## Feature 07 Analysis: Log Capture Workflow Validation

Problem:
- Logs are not consistently captured per feature.

What we need:
- predictable log collection and naming.

Concepts:
- Observability
- Traceability for debugging

Risks:
- Large or noisy log artifacts.

Mitigation:
- Scope log captures and keep indexing simple.

## Feature 08 Analysis: MVP API/Event Model Cleanup

Problem:
- Current contract is conceptual, not strict enough for coding.

What we need:
- concrete event definitions, ownership boundaries, and payload shape.

Concepts:
- Contract-first design
- API minimalism
- Event-driven modeling

Risks:
- Overdesign too early.

Mitigation:
- Keep MVP contract narrow and extensible.

## Feature 09 Analysis: System Architecture Cleanup

Problem:
- Long-form architecture docs are harder to execute from.

What we need:
- concise implementation-facing architecture map.

Concepts:
- Separation of concerns
- Layered ownership

Risks:
- Removing useful context.

Mitigation:
- Keep archive as reference, write concise execution architecture.

## Feature 10 Analysis: Demo Scenario Validation

Problem:
- Demos can fail without deterministic scenario checks.

What we need:
- exact preconditions, commands, and expected outcomes.

Concepts:
- Deterministic demos
- Product storytelling through engineering evidence

Risks:
- Manual demo steps drift over time.

Mitigation:
- Script as much as possible and version scenario definitions.

## Feature 11 Analysis: GitHub Publishing Readiness

Problem:
- Technical work can look weak if repo quality is inconsistent.

What we need:
- clean docs entry, no secrets, visible implementation flow.

Concepts:
- Developer experience (DX)
- Public engineering credibility

Risks:
- exposing non-public material.

Mitigation:
- include checklist and explicit exclusions.

## Feature 12 Analysis: Course-Ready Summary Generation

Problem:
- Knowledge may stay implicit and hard to teach later.

What we need:
- standard summary after each feature.

Concepts:
- Knowledge capture
- Instructional design for engineering projects

Risks:
- summaries become too long or inconsistent.

Mitigation:
- enforce compact template per feature.

## Dependency Order

1. F01 -> F02 -> F03 -> F04
2. F05 -> F06 -> F07
3. F08 -> F09 -> F10
4. F11 -> F12

## Today Priorities

1. Feature 02
2. Feature 03
3. Feature 04
