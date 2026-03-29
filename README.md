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

## Already Replicated

| Paper | Status | Replicated By | CLEAN Works? | Reason |
|-------|--------|---------------|--------------|--------|
| Olar (2019) JPR — Diffusion of Repression | Completed | Jack | Yes | |
| Nyhan & Montgomery (2015) JoP — Connecting the Candidates | Completed | Zihuan | Yes | Block dummies alone explain Wy (neighbors' avg strategy): Risk-taking R²=0.41, Issue ownership R²=0.76 |
| Beck, Gleditsch & Beardsley (2006) ISQ — Space Is More than Geography (Table 1: Democracy & Social Requisites) | Completed | Deki | Yes | High correlation between Wy and CLEAN blocks (R²=0.75) |
| Wimpy, Whitten & Williams (2021) JoP — X Marks the Spot | Completed | Zihuan | NO | R² = 0.102: block membership explains only 10% of Wy, and geographical contiguity is a strong direct connection not just a proxy of similarity |
| Böhmelt, Ruggeri & Pilster (2017) — Counterbalancing, Spatial Dependence & Peer Group Effects | Completed | Deki | TBD | The published significance is not the same as replicated significance (the original paper used STATA to apply empirical analysis) |
| Hinkle (2014) AJPS — Federal Courts and State Policy Diffusion | Completed | Zihuan | Not applicable | No Wy |
| Genovese, Kern & Martin (2017) ISQ — Policy Alteration | Completed | Zihuan | Not applicable | All nodes fully connected, no CLEAN blocks |
| How Parties React to Voter Transitions (year/journal TBD) | Completed | Jack | Not applicable | W matrix encodes co-exposure (vote loss weights), not true network contagion; CLEAN requires genuine network dependency |
| Böhmelt et al. (2017) ISQ — Why Dominant Governing Parties Are Cross-Nationally Influential | Completed | Insu | No | Double Check |
| Beck, Gleditsch & Beardsley (2006) ISQ — Space Is More than Geography (Table 2: Directed Export Flows) | Completed | Deki | No | Very sparse network |
| Montgomery & Nyhan (2017) JoP — Congressional Staff Networks | Completed | Deki, Insu | No | Extremely sparse networks (all-staff density ≈ 0.115%, senior-staff density ≈ 0.025%) |
| Williams & Whitten (2014) AJPS — Don't Stand So Close to Me: Spatial Contagion & Party Competition | Completed | Deki | No | CLEAN blocks explain only ~2.2% of spatial lag |
| Kinne (2024) ISQ — Network Context and Effectiveness of International Agreements | Completed | Insu | Ambiguous | Author did not provide exact Wy raw data |
| Gannon (2025) AJPS — Complementarity in Alliances | Completed | Insu | Ambiguous | Author did not provide exact Wy raw data |

### Ready to be Replicated (checked by Zihuan)
| Paper | Status |
| --- | --- |
| Desmarais & Uppala (2023) PA — Contagion, Confounding, Causality | Deki |
| Malang et al. (2019) BJPS — Networks and Social Influence (EU legislatures) | Deki |
| Dorff et al. (2023) BJPS — Network Competition and Civilian Targeting | No matrix |
| Aidt & Leon-Ablan (2022) BJPS — Diffusion in Social Unrest (Swing Riots) | No time variation |
| Garcia & Wimpy (2016) PSRM — Does Information Lead to Emulation? | No data |
| Ruggeri et al. (2017) PSRM — Counterbalancing, Spatial Dependence, Peer Effects | No data |
| Lindstädt et al. (2017) PSRM — Diffusion in Congress | No data |
| Metternich et al. (2017) JCR — Firewall? Or Wall on Fire? | No data |
| Gade et al. (2019) JCR — Networks of Cooperation (rebel alliances) | No data |
| Weidmann (2015) JPR — Communication Networks and Ethnic Conflict | No data |
| Gade et al. (2019) JPR — Fratricide in Rebel Movements | No time variation |
| Sommerer & Tallberg (2019) IO — Diffusion Across International Organizations | No data |
| Dorff, Gallop & Minhas (2022) ISQ — What Lies Beneath: Using Latent Networks to Improve Spatial Predictions | No matrix |
| Abramson, Carter & Ying (2022) APSR — Historical Border Changes, State Building, and Contemporary Trust in Europe | Zihuan |
| Shaw et al. (TBD) — Show Me the Money: Interjurisdictional Political Competition and Fiscal Extraction in China | Insu |
| Beck, Gleditsch & Beardsley (2006) JoP — Space Is More than Geography | No data |
| Franzese & Hays (2007) PA — Spatial Econometric Models of Cross-Sectional Interdependence | No data |
| Neumayer & Plümper (2012) CPS — Conditional Spatial Policy Dependence: Theory and Model Specification | No data |
| Steinwand (2015) IO — Compete or Coordinate? Aid Fragmentation and Lead Donorship | No data |
| Wibbels & Ahlquist (2011) ISQ — Trade, Development, and Social Insurance | Insu |
| Schleiter, Böhmelt, Ezrow & Lehrer (2021) WP — Social Democratic Party Exceptionalism and Transnational Policy Linkages | No matrix |
| Cook, Hays & Franzese (2022) APSR — STADL Up! The Spatiotemporal Autoregressive Distributed Lag Model for TSCS Data Analysis | Reanalysis of Acemoglu et al. (2008) on Development and Democracy |
| Betz, Cook & Hollenbach (2021) PA — Bias from Network Misspecification Under Spatial Dependence | No matrix |
| Franzese, Hays & Cook (2016) PSRM — Spatial- and Spatiotemporal-Autoregressive Probit Models of Interdependent Binary Outcomes | No data |
| Franzese & Hays (2006) EUP — Strategic Interaction among EU Governments in Active-Labor-Market Policymaking | TBD |
| Franzese & Hays (2008) CPS — Interdependence in Comparative Politics | TBD |

## Claude Code slash commands

- `/clean-replicate` — Step-by-step workflow to apply CLEAN to a new paper
- `/paper-candidates` — Track and search for candidate papers to replicate

## Requirements

- R with packages: `CLEAN`, `spatialreg`, `spdep`, `tidyverse`, `igraph`, `modelsummary`, `knitr`, `kableExtra`
- Quarto (for rendering `.qmd` replication files)
