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

### Successful Replication 

| Paper | Status | Replicated By | CLEAN Works? | Reason |
|-------|--------|---------------|--------------|--------|
| Olar (2019) JPR — Diffusion of Repression | Completed | Jack | Yes | |
| Nyhan & Montgomery (2015) JoP — Connecting the Candidates | Completed | Zihuan | Yes | Block dummies alone explain Wy (neighbors' avg strategy): Risk-taking R²=0.41, Issue ownership R²=0.76 |
| Beck, Gleditsch & Beardsley (2006) ISQ — Space Is More than Geography (Table 1: Democracy & Social Requisites) | Completed | Deki | Yes | High correlation between Wy and CLEAN blocks (R²=0.75) |
| Franzese, Hays & Cook (2016) PSRM — Spatial- and Spatiotemporal-Autoregressive Probit Models of Interdependent Binary Outcomes | Completed | Deki | Yes | Using MATLAB, CLEAN works so well that, after incorporating it, the significance (stars) of the initial rho values disappears for both models. The R-squared from the collinearity check does not seem to explain this, as it is only 0.270. |


### Failed Replication
| Steinwand (2015) IO — Compete or Coordinate? Aid Fragmentation and Lead Donorship | Completed | Deki | No | the significance of the rho values does not change. However, there are some changes in the point estimates of rho and their standard errors after incorporating CLEAN. The R-squared for the collinearity check is 0.450. |
| Wimpy, Whitten & Williams (2021) JoP — X Marks the Spot | Completed | Zihuan | NO | R² = 0.102: block membership explains only 10% of Wy, and geographical contiguity is a strong direct connection not just a proxy of similarity |
| Montgomery & Nyhan (2017) JoP — Congressional Staff Networks | Completed | Deki, Insu | No | Extremely sparse networks (all-staff density ≈ 0.115%, senior-staff density ≈ 0.025%) |
| Williams & Whitten (2014) AJPS — Don't Stand So Close to Me: Spatial Contagion & Party Competition | Completed | Deki | No | CLEAN blocks explain only ~2.2% of spatial lag |
| Shiffman et al. (2022) ISQ — Social Construction of Global Health Priorities | Completed | Deki | No | changes in the rho value, but the statistical significance (stars) remains unchanged. block membership explains only 2.9% of Wy | 


### Ready to be Replicated (Data Available, checked by Zihuan, need to check whether it has matrix or time variation)
| Paper | Status |
| --- | --- |
| Franzese & Hays (2006) EUP — Strategic Interaction among EU Governments in Active-Labor-Market Policymaking | Data available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/FEA4T2 |
| Franzese & Hays (2008) CPS — Interdependence in Comparative Politics | Data available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/C1O8HS |
| Gilardi (2021) AJPS — Policy Diffusion: The Issue-Definition Stage | Data Available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/QEMNP1 |
| Büyükkeles & Özel (2019) ISQ — Regulatory Convergence in the Financial Periphery | Data Available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/VBNPJS |
| Price (2018) ISQ — Diffusion Effect of Militant Leadership Decapitation | Data Available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/VFNSX6 |
| Desmarais & Cranmer (2017) AJPS — Statistical Tools for Inferential Network Analysis | Data Available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/2XP8YF |
| Simmons & Elkins (2004) APSR — Globalization of Liberalization | Data Available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/81MG6A |
| Desmarais & Cranmer (2022) ISQ — Modeling Diffusion through Network Analysis | Data Available: https://academic.oup.com/isq/article/66/1/sqab087/6425795?login=true&guestAccessKey=#no-access-message#no-access-message |
| Barthel & Neumayer (2012) ISQ — Diffusion of Double Taxation Treaties | Data Available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/0COWAL |
| Swank (2010) ISQ — Networks and Capital Taxation Diffusion | Data available: https://www.isanet.org/Publications/ISQ/Replication-Data?doi=10.1093/isq/sqv023 |
| Doten-Snitker, K. (2024) CPS — The Diffusion of Exclusion: Medieval Expulsions of Jews | Data Available: https://doi.org/10.7910/DVN/SCJL8I |
| Metternich, N.W. & Wucherpfennig, J. (2020) International Interactions — Strategic Rebels: A Spatial Econometric Approach to Rebel Fighting Durations in Civil Wars | Data Available: https://doi.org/10.7910/DVN/XUVHCH |
| Aidt, T., León, G. & Satchell, M. (2021) JoP — The Social Dynamics of Collective Action: Evidence from the Diffusion of the Swing Riots, 1830–31 | Data Available: https://doi.org/10.7910/DVN/VIXZD1 |
| Forsberg, E. (2014) International Interactions — Transnational Transmitters: Ethnic Kinship Ties and Conflict Contagion 1946–2009 | Data Available: https://doi.org/10.7910/DVN/25769 |
| Ward, H. & John, P. (2013) PSRM — Competitive Learning in Yardstick Competition: Testing Models of Policy Diffusion With Performance Data | Data Available: https://doi.org/10.7910/DVN/B4VBVM |

### Papers using STATA
| Miller (2016) JCR — Are Coups Really Contagious? | Data Available: https://journals.sagepub.com/doi/abs/10.1177/0022002716649232 STATA |
| Böhmelt, T. (2016) JPR — The Importance of Conflict Characteristics for the Diffusion of International Mediation | Data available: https://www.prio.org/journals/jpr/replicationdata STATA|
| Polo, S.M.T. (2020) JCR — How Terrorism Spreads: Emulation and the Diffusion of Ethnic and Ethnoreligious Terrorism | Data available: https://journals.sagepub.com/doi/full/10.1177/0022002720930811 STATA |


### CLEAN doesn't work
| Beck, Gleditsch & Beardsley (2006) ISQ — Space Is More than Geography (Table 2: Directed Export Flows) | Completed | Deki | No | Very sparse network |
| Böhmelt, Ruggeri & Pilster (2017) — Counterbalancing, Spatial Dependence & Peer Group Effects | Completed | Deki | TBD | The published significance is not the same as replicated significance (the original paper used STATA to apply empirical analysis) |
| Böhmelt et al. (2017) ISQ — Why Dominant Governing Parties Are Cross-Nationally Influential | Completed | Insu | No | Double Check |
| Shaw et al. (TBD) — Show Me the Money: Interjurisdictional Political Competition and Fiscal Extraction in China | Completed | Insu | No | Double Check |
| Wibbels & Ahlquist (2011) ISQ — Trade, Development, and Social Insurance | Completed | Insu | No | Double Check |
| Hinkle (2014) AJPS — Federal Courts and State Policy Diffusion | Completed | Zihuan | Not applicable | No Wy |
| Genovese, Kern & Martin (2017) ISQ — Policy Alteration | Completed | Zihuan | Not applicable | All nodes fully connected, no CLEAN blocks |
| How Parties React to Voter Transitions (year/journal TBD) | Completed | Jack | Not applicable | W matrix encodes co-exposure (vote loss weights), not true network contagion; CLEAN requires genuine network dependency |
| Desmarais & Uppala (2023) PA — Contagion, Confounding, Causality | Completed | Deki | Not applicable | Methodological paper |
| Malang et al. (2019) BJPS — Networks and Social Influence (EU legislatures) | Completed | Deki | Not applicable | No Wy |
| Chaney (2023) AJPS — Policy Networks Across Political Systems | Completed | Insu | Not applicable | No Wy |
| Kinne (2024) ISQ — Network Context and Effectiveness of International Agreements | Completed | Insu | Ambiguous | No Wy data |
| Gannon (2025) AJPS — Complementarity in Alliances | Completed | Insu | Ambiguous | No Wy data |


### Bad candidates (Matrix, time-variation, method papers: TBD)
| Paper | Status |
| --- | --- |
| Neumayer & Plümper (2012) CPS — Conditional Spatial Policy Dependence: Theory and Model Specification | Data Available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/UVSMOV stcox (Cox proportional hazards / survival analysis), not a linear SAR model, and there is no standalone W matrix file |
| Abramson, Carter & Ying (2022) APSR — Historical Border Changes, State Building, and Contemporary Trust in Europe | Data Available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/5O3EOW no spatial lag model and no W matrix |
| Sommerer & Tallberg (2019) IO — Diffusion Across International Organizations | Data available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/KYBEM4 no spatial lag model; uses dyadic logit; most matrices are static |
| Lindstädt et al. (2017) PSRM — Diffusion in Congress | Data available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/CJZB8X no W matrix in the data and no rho to adjust |
| Garcia & Wimpy (2016) PSRM — Does Information Lead to Emulation? | Data available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/CTRV5Z no matrix|
| Goodliffe, J. & Hawkins, D. (2015) JCR — Dependence Networks and the Diffusion of Domestic Political Institutions | Data available: https://journals.sagepub.com/doi/full/10.1177/0022002715596772 No matrix |
| Metternich, N.W., Minhas, S. & Ward, M.D. (2017) JCR — Firewall? or Wall on Fire? Conflict Contagion and the Role of Ethnic Networks | Data available: https://journals.sagepub.com/doi/full/10.1177/0022002715603452 GBME model — Bayesian, MCMC, no  ρ  |
| Gade et al. (2019) JCR — Networks of Cooperation (rebel alliances) | Data available: https://journals.sagepub.com/doi/full/10.1177/0022002719826234 use AME models. There is no ρ in this paper |
| Aidt & Leon-Ablan (2022) BJPS — Diffusion in Social Unrest (Swing Riots) | No time variation |
| Gade et al. (2019) JPR — Fratricide in Rebel Movements | No time variation |
| Dorff, Gallop & Minhas (2022) ISQ — What Lies Beneath: Using Latent Networks to Improve Spatial Predictions | No matrix |
| Schleiter, Böhmelt, Ezrow & Lehrer (2021) WP — Social Democratic Party Exceptionalism and Transnational Policy Linkages | No matrix |
| Betz, Cook & Hollenbach (2021) PA — Bias from Network Misspecification Under Spatial Dependence | No matrix |
| Dorff et al. (2023) BJPS — Network Competition and Civilian Targeting | No matrix |
| Franzese & Hays (2017) PA — Spatial Econometric Models of Cross-Sectional Interdependence | Methodological paper |
| Cook, Hays & Franzese (2022) APSR — STADL Up! The Spatiotemporal Autoregressive Distributed Lag Model for TSCS Data Analysis | Reanalysis of Acemoglu et al. (2008) on Development and Democracy |
| Greenhill, B. (2010) ISQ — The Company You Keep: International Socialization and the Diffusion of Human Rights Norms | Data Available: https://doi.org/10.7910/DVN/40FMWG, but no matrix |

### No data (Data availability: TBD)
| Paper | Status |
| --- | --- |
| Madsen (2022) JOP — Diffusing Political Concerns among Danish Voters | TBD, no access to Chicago Press |
| Böhmelt, T., Ezrow, L. & Lehrer, R. (2016) APSR — Party Policy Diffusion | No data (APSR requires replication — check Cambridge Core supplementary) |
| Weidmann (2015) JPR — Communication Networks and Ethnic Conflict | Data available, but no Wy data : https://www.prio.org/journals/jpr/replicationdata |
| Böhmelt, T. & Bove, V. (2019) JPR — Does Cultural Proximity Contain Terrorism Diffusion? | Data available, but failed to open the link: https://journals.sagepub.com/doi/10.1177/0022343319864425 |
| Flores, A. (2011) CMPS — Alliances as Contiguity in Spatial Models of Military Expenditures | Data available, but failed to open the link: https://journals.sagepub.com/doi/10.1177/0738894211413064 http://privatewww.essex.ac.uk/~ksg/ |
| Oneal, J.R., Russett, B. & Berbaum, M.L. (2003) ISQ — Causes of Peace: Democracy, Interdependence, and International Organizations, 1885–1992 | Data available, but failed to open the link: https://academic.oup.com/isq/article/47/3/371/1923564?login=true&guestAccessKey=#authorNotesSectionTitle |

## Claude Code slash commands

- `/clean-replicate` — Step-by-step workflow to apply CLEAN to a new paper
- `/paper-candidates` — Track and search for candidate papers to replicate

## Requirements

- R with packages: `CLEAN`, `spatialreg`, `spdep`, `tidyverse`, `igraph`, `modelsummary`, `knitr`, `kableExtra`
- Quarto (for rendering `.qmd` replication files)
