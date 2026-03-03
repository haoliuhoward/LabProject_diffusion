# LabProject_diffusion

Research project applying the **CLEAN method** (Confounding Latent Embedding Adjustment
for Networks) to replicate political science papers that use spatial lag (SAR) models.

CLEAN tests whether a paper's spatial lag coefficient ρ survives controlling for latent
network homophily — i.e., whether diffusion effects are real or artifacts of unobserved
similarity between connected units.

## Repository structure

```
LabProject_diffusion/
├── tutorial_materials/
│   ├── CLEAN_main.pdf                        # CLEAN methodology paper
│   ├── CLEAN_tutorial_sbm.pdf                # Tutorial: CLEAN with stochastic block models
│   └── Replication_with_Claude_Tutorial.html # Walkthrough of the replication workflow
├── replication_template/
│   └── replication_with_claude_template/     # Template for new replications
│       ├── Replication_paper.pdf             # Paper being replicated (Nyhan & Montgomery 2015)
│       ├── CLEAN_main.pdf
│       ├── CLEAN_tutorial_sbm.pdf
│       ├── .claude/commands/clean-replicate.md
│       └── data/                                        # Please replace this with new replication data             
└── .claude/commands/                         # Claude Code slash commands
    ├── clean-replicate.md
    └── paper-candidates.md
```

## Replications

| Paper | Status |
|-------|--------|
| Hinkle (2014) AJPS — Federal Courts and State Policy Diffusion | In progress |
| Genovese, Kern & Martin (2017) ISQ — Policy Alteration | Completed |
| Wimpy, Whitten & Williams (2021) JoP — X Marks the Spot | In progress |
| Nyhan & Montgomery (2015) JoP — Connecting the Candidates | QMD done |
| Olar (2019) JPR — Diffusion of Repression | Tutorial stage |

## Claude Code slash commands

- `/clean-replicate` — Step-by-step workflow to apply CLEAN to a new paper
- `/paper-candidates` — Track and search for candidate papers to replicate

## Requirements

- R with packages: `CLEAN`, `spatialreg`, `spdep`, `tidyverse`, `igraph`, `modelsummary`, `knitr`, `kableExtra`
- Quarto (for rendering `.qmd` replication files)
