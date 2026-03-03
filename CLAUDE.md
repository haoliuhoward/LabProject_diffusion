# CLAUDE.md — LabProject_diffusion

## Project overview

This repo applies the CLEAN method (Confounding Latent Embedding Adjustment for Networks)
to replicate political science papers using spatial lag (SAR) models. Core question: does
ρ survive controlling for latent homophily detected via stochastic block models (SBMs)?

## Slash commands

- `/clean-replicate` — Guided workflow (Steps 0–4) to apply CLEAN to a new paper and produce a QMD
- `/paper-candidates` — Maintains a tracked list of candidate SAR-model papers to replicate

## Key R helpers

- `clean_blocks()` / `clean_blocks_by_time()` — static vs. time-varying network
- `compute_Wy(adj, sel, data, col)` — manually compute spatial lag of outcomes
- `add_clean(f)` — `update(f, . ~ . + clean_block)`

## Conventions

- SBM type: `"bernoulli"` (binary W), `"poisson"` (count), `"gaussian"` (continuous)
- Always `seed = 1` unless told otherwise
- Always `mat2listw(..., zero.policy = TRUE)` in `run_sar()`
- Table captions: Unicode `ρ`, plain `Wy` — no raw LaTeX (breaks HTML output)
- Suppress verbose SBM chunk: `echo=FALSE, results='hide', message=FALSE, warning=FALSE, fig.show='hide'`
