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
│       └── data/                         # Please replace this with new replication data             
└── .claude/commands/                         # Claude Code slash commands
    ├── clean-replicate.md
    └── paper-candidates.md
```

## Replications

| Paper | Status | Replicated By | CLEAN Works? | Reason |
|-------|--------|---------------|--------------|--------|
| Nyhan & Montgomery (2015) JoP — Connecting the Candidates | Completed | Zihuan | Yes | Block dummies alone explain Wy (neighbors' avg strategy): Risk-taking R²=0.41, Issue ownership R²=0.76 |
| Beck, Gleditsch & Beardsley (2006) ISQ — Space Is More than Geography (Table 1: Democracy & Social Requisites) | Completed | Deki | Yes | High correlation between Wy and CLEAN blocks (R²=0.75) |
| Böhmelt et al. (2017) ISQ — Why Dominant Governing Parties Are Cross-Nationally Influential | Completed | Insu | Yes | TBD |
| Beck, Gleditsch & Beardsley (2006) ISQ — Space Is More than Geography (Table 2: Directed Export Flows) | Completed | Deki | No | Very sparse network |
| Montgomery & Nyhan (2017) JoP — Congressional Staff Networks | Completed | Deki, Insu | No | Extremely sparse networks (all-staff density ≈ 0.115%, senior-staff density ≈ 0.025%) |
| Williams & Whitten (2014) AJPS — Don't Stand So Close to Me: Spatial Contagion & Party Competition | Completed | Deki | No | CLEAN blocks explain only ~2.2% of spatial lag |
| Hinkle (2014) AJPS — Federal Courts and State Policy Diffusion | Completed | Zihuan | Not applicable | No Wy |
| Genovese, Kern & Martin (2017) ISQ — Policy Alteration | Completed | Zihuan | Not applicable | All nodes fully connected, no CLEAN blocks |
| How Parties React to Voter Transitions (year/journal TBD) | Completed | Jack | Not applicable | W matrix encodes co-exposure (vote loss weights), not true network contagion; CLEAN requires genuine network dependency |
| Kinne (2024) ISQ — Network Context and Effectiveness of International Agreements | Completed | Insu | Ambiguous | Author did not provide exact Wy raw data |
| Gannon (2025) AJPS — Complementarity in Alliances | Completed | Insu | Ambiguous | Author did not provide exact Wy raw data |
| Olar (2019) JPR — Diffusion of Repression | Completed | Jack | | |
| Wimpy, Whitten & Williams (2021) JoP — X Marks the Spot | In progress | Zihuan | | |
| Böhmelt, Ruggeri & Pilster (2017) — Counterbalancing, Spatial Dependence & Peer Group Effects | In progress | Deki | TBD | Could not reproduce original results; re-replicating with Claude Code |

## Claude Code slash commands

- `/clean-replicate` — Step-by-step workflow to apply CLEAN to a new paper
- `/paper-candidates` — Track and search for candidate papers to replicate

## Requirements

- R with packages: `CLEAN`, `spatialreg`, `spdep`, `tidyverse`, `igraph`, `modelsummary`, `knitr`, `kableExtra`
- Quarto (for rendering `.qmd` replication files)
