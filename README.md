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
| Paper | Status | Replicated By | CLEAN Works? | Reason |
|-------|--------|---------------|--------------|--------|
| Steinwand (2015) IO — Compete or Coordinate? Aid Fragmentation and Lead Donorship | Completed | Deki | No | the significance of the rho values does not change. However, there are some changes in the point estimates of rho and their standard errors after incorporating CLEAN. The R-squared for the collinearity check is 0.450. |
| Wimpy, Whitten & Williams (2021) JoP — X Marks the Spot | Completed | Zihuan | NO | R² = 0.102: block membership explains only 10% of Wy, and geographical contiguity is a strong direct connection not just a proxy of similarity |
| Montgomery & Nyhan (2017) JoP — Congressional Staff Networks | Completed | Deki, Insu | No | Extremely sparse networks (all-staff density ≈ 0.115%, senior-staff density ≈ 0.025%) |
| Williams & Whitten (2014) AJPS — Don't Stand So Close to Me: Spatial Contagion & Party Competition | Completed | Deki | No | CLEAN blocks explain only ~2.2% of spatial lag |
| Shiffman et al. (2022) ISQ — Social Construction of Global Health Priorities | Completed | Deki | No | changes in the rho value, but the statistical significance (stars) remains unchanged. block membership explains only 2.9% of Wy | 
| Böhmelt et al. (2017) ISQ — Why Dominant Governing Parties Are Cross-Nationally Influential | Completed | Zihuan | No | changes in the rho value, but the statistical significance (stars) remains unchanged | 
| Polo, S.M.T. (2020) JCR — How Terrorism Spreads: Emulation and the Diffusion of Ethnic and Ethnoreligious Terrorism | Completed | Zihuan | changes in the rho value, but the statistical significance (stars) remains unchanged | 
| Neumayer & Plümper (2010) CMPS — Galton's Problem and Contagion in International Terrorism along Civilizational Lines | Completed | Zihuan | changes in the rho value, but the statistical significance (stars) remains unchanged | 

### Paper Assigned
| Paper | Assignee |
| --- | --- |
| Franzese & Hays (2006) EUP — Strategic Interaction among EU Governments in Active-Labor-Market Policymaking | Deki |
| Franzese & Hays (2008) CPS — Interdependence in Comparative Politics | Deki |

### Matrices missing
| Paper | Status | Replicated By | CLEAN Works? | Reason |
|-------|--------|---------------|--------------|--------|
| Kinne (2024) ISQ — Network Context and Effectiveness of International Agreements |  No Wy data |
| Gannon (2025) AJPS — Complementarity in Alliances |  No Wy data |
| How Parties React to Voter Transitions (year/journal TBD) | W matrix encodes co-exposure (vote loss weights) |
| Desmarais & Cranmer (2017) AJPS — Statistical Tools for Inferential Network Analysis | No Wy data |
| Garcia & Wimpy (2016) PSRM — Does Information Lead to Emulation? | Data available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/CTRV5Z no matrix |
| Goodliffe, J. & Hawkins, D. (2015) JCR — Dependence Networks and the Diffusion of Domestic Political Institutions | Data available: https://journals.sagepub.com/doi/full/10.1177/0022002715596772 No matrix |
| Dorff, Gallop & Minhas (2022) ISQ — What Lies Beneath: Using Latent Networks to Improve Spatial Predictions | No matrix |
| Schleiter, Böhmelt, Ezrow & Lehrer (2021) WP — Social Democratic Party Exceptionalism and Transnational Policy Linkages | No matrix |
| Betz, Cook & Hollenbach (2021) PA — Bias from Network Misspecification Under Spatial Dependence | No matrix |
| Dorff et al. (2023) BJPS — Network Competition and Civilian Targeting | No matrix |
| Greenhill, B. (2010) ISQ — The Company You Keep: International Socialization and the Diffusion of Human Rights Norms | Data Available: https://doi.org/10.7910/DVN/40FMWG, but no matrix |

### Papers needs Alex to check
| Paper | Status |
| --- | --- |
| Metternich, N.W. & Wucherpfennig, J. (2020) International Interactions — Strategic Rebels: A Spatial Econometric Approach to Rebel Fighting Durations in Civil Wars | Data Available: https://doi.org/10.7910/DVN/XUVHCH |
| Forsberg, E. (2014) International Interactions — Transnational Transmitters: Ethnic Kinship Ties and Conflict Contagion 1946–2009 | Data Available: https://doi.org/10.7910/DVN/25769 |
| Braithwaite, Braithwaite & Kucik (2015) JPR — The Conditioning Effect of Protest History on the Emulation of Nonviolent Conflict | Data available: https://www.prio.org/journals/jpr/replicationdata |
| Lane (2016) JoP — The Intrastate Contagion of Ethnic Civil War | https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/4HFPNH  |
| Clay & Owsiak (2015) JoP — The Diffusion of International Border Agreements | https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/WBBAE3 |
| Cao (2010) ISQ — Networks and Capital Taxation Diffusion | Data available: https://www.isanet.org/Publications/ISQ/Replication-Data?doi=10.1093/isq/sqv023 |
| Aidt, T., León, G. & Satchell, M. (2021) JoP — The Social Dynamics of Collective Action: Evidence from the Diffusion of the Swing Riots, 1830–31 | Data Available: https://doi.org/10.7910/DVN/VIXZD1 |

### Papers waiting for cheking
| Paper | Status |
| --- | --- |
| Böhmelt & Bove (2019) EJPR — How Migration Policies Moderate the Diffusion of Terrorism | https://onlinelibrary.wiley.com/doi/epdf/10.1111/1475-6765.12339 |
| Ambrosio (2010) ISP — Constructing a Framework of Authoritarian Diffusion | Data available: |
| Oneal, Russett & Berbaum (2003) ISQ — Causes of Peace: Democracy, Interdependence, and International Organizations, 1885–1992 | Data available: |
| Murdoch & Sandler (2002) JCR — Economic Growth, Civil Wars, and Spatial Spillovers | Data available: |


### Bad candidates (Matrix, time-variation, method papers: TBD)
| Paper | Status |
| --- | --- |
| Böhmelt, Ruggeri & Pilster (2017) — Counterbalancing, Spatial Dependence & Peer Group Effects | Completed by Deki: The published significance is not the same as replicated significance (the original paper used STATA to apply empirical analysis) Checked by Zihuan, No time dimension | 
| Elkins, Guzmán & Simmons (2006) IO — Competing for Capital: The Diffusion of Bilateral Investment Treaties, 1959–2000 | Data available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/QJQYPK Cox PH Model |
| Kathman (2010) ISQ — Civil War Contagion and Neighboring Interventions | Data available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/QDELJ8 logit model |
| Braithwaite (2010) JPR — Resisting Infection: How State Capacity Conditions Conflict Contagion | Data available: https://www.prio.org/journals/jpr/replicationdata not Sar Model |
| Greenhill (2010) ISQ — The Company You Keep: International Socialization and the Diffusion of Human Rights Norms | Data available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/GLEY3J Ordered probit Model |
| Madsen (2022) JOP — Diffusing Political Concerns among Danish Voters | https://dataverse.harvard.edu/dataset.xhtml;jsessionid=908396565f2ebd923f8676adfb0c?persistentId=doi%3A10.7910%2FDVN%2FHOLUME&version=&q=&fileTypeGroupFacet=%22Code%22&fileAccess=&fileTag=&fileSortField=&fileSortOrder= No Wy |
| Black (2013) JPR — When Have Violent Civil Conflicts Spread? | Data available: https://www.prio.org/journals/jpr/replicationdata logit model |
| Desmarais & Cranmer (2022) ISQ — Modeling Diffusion through Network Analysis | FHC estimato Model |
| Franzese & Hays (2007) PA — Spatial Econometric Models of Cross-Sectional Interdependence in Political Science Panel and Time-Series-Cross-Section Data | Method Paper |
| Franzese & Hays (2008) CPS — Interdependence in Comparative Politics | Method Paper |
| Neumayer & Plümper (2010) IO — Spatial Effects in Dyadic Data | Method Paper |
| Miller (2016) JCR — Are Coups Really Contagious? | Logit Model, No Wy |
| Barthel & Neumayer (2012) ISQ — Diffusion of Double Taxation Treaties | spatial Cox proportional hazard model |
| Doten-Snitker, K. (2024) CPS — The Diffusion of Exclusion: Medieval Expulsions of Jews | Bayesian hierarchical logistic regression |
| Ward, H. & John, P. (2013) PSRM — Competitive Learning in Yardstick Competition: Testing Models of Policy Diffusion With Performance Data | no time variation |
| Böhmelt, T. (2016) JPR — The Importance of Conflict Characteristics for the Diffusion of International Mediation | No time variation |
| Jordana, Levi-Faur & Fernández-i-Marín (2011) CPS — The Global Diffusion of Regulatory Agencies | Data available: logit model |
| Kathman (2011) JCR — Civil War Diffusion and Regional Motivations for Intervention | Data available: logit analysis |
| Elkink (2011) CPS — The International Diffusion of Democracy | Data available: computer simulation model |
| Brooks & Kurtz (2012) IO — Paths to Financial Policy Diffusion: Statist Legacies in Latin America's Globalization | Data available: time-series analysis model |
| Saideman (2012) II — When Conflict Spreads: Arab Spring and the Limits of Diffusion | Data available: qualitative research |
| Solingen (2012) ISQ — Of Dominoes and Firewalls: The Domestic, Regional, and Global Politics of International Diffusion | Data available: Review |
| Linebarger (2015) II — Civil War Diffusion and the Emergence of Militant Groups, 1960–2001 | not SAR model |
| Kıbrıs (2021) JPR — The Geo-Temporal Evolution of Violence in Civil Conflicts | split population bi-probit model |
| Glasius, Schalk & de Lange (2020) ISQ — Illiberal Norm Diffusion |  Negative Binomial Regression |
| Sarıgil (2020) JPR — A Micro-Level Analysis of the Contagion Effect: Evidence from the Kurdish Conflict | Cox proportional hazards model  |
| Goldring & Greitens (2019) CPS — Rethinking Democratic Diffusion: Bringing Regime Type Back In | SLX-logit model |
| Betz, Cook & Hollenbach (2019) PSRM — Spatial Interdependence and Instrumental Variable Models |  iv + spatial interdependence |
| Simmons, Lloyd & Stewart (2018) IO — The Global Diffusion of Law: Transnational Crime and the Case of Human Trafficking | Cox proportional hazards model |
| Crabtree, Kern & Pfaff (2018) ISQ — Mass Media and the Diffusion of Collective Action in Authoritarian Regimes | probit model |
| Juhl (2018) PA — Measurement Uncertainty in Spatial Models: A Bayesian Dynamic Measurement Model | Bayesian model |
| Harbers & Ingram (2017) PA — Geo-Nested Analysis: Mixed-Methods Research with Spatially Dependent Data | method paper |
| Gomez & Winger (2024) JPR — Third-Party Countries in Cyber Conflict | No Wy |
| Magee & Massoud (2022) II — Diffusion of Protests in the Arab Spring | Not SAR Model |
| Kim, Liu & Desmarais (2022) PSRM — Spatial Modeling of Dyadic Geopolitical Interactions Between Moving Actors |  AMEN Model |
| Böhmelt (2014) CMPS — The Spatial Contagion of International Mediation | No data |
| Phillips (2014) CMPS — Civil War, Spillover and Neighbors' Military Spending | No Wy |
| Bell, Clay & Murdie (2012) JoP — Neighborhood Watch: Spatial Effects of Human Rights INGOs | Not SAR Model |
| Baccini & Dür (2011) BJPS — The New Regionalism and Policy Interdependence | Not SAR Model |
| Zhukov & Stewart (2012) ISQ — Choosing Your Neighbors: Networks of Diffusion in International Relations | No Wy |
| Brooks, Cunha & Mosley (2014) ISQ — Categories, Creditworthiness, and Contagion | ECM model |
| Büyükkeles & Özel (2019) ISQ — Regulatory Convergence in the Financial Periphery | cross-sectional analysis, not a time panel |
| Price (2018) ISQ — Diffusion Effect of Militant Leadership Decapitation | No Wy |
| Gilardi (2021) AJPS — Policy Diffusion: The Issue-Definition Stage | No Wy |
| Neumayer & Plümper (2012) CPS — Conditional Spatial Policy Dependence: Theory and Model Specification | Data Available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/UVSMOV stcox (Cox proportional hazards / survival analysis), not a linear SAR model, and there is no standalone W matrix file |
| Abramson, Carter & Ying (2022) APSR — Historical Border Changes, State Building, and Contemporary Trust in Europe | Data Available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/5O3EOW no spatial lag model and no W matrix |
| Sommerer & Tallberg (2019) IO — Diffusion Across International Organizations | Data available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/KYBEM4 no spatial lag model; uses dyadic logit; most matrices are static |
| Lindstädt et al. (2017) PSRM — Diffusion in Congress | Data available: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/CJZB8X no W matrix in the data and no rho to adjust |
| Metternich, N.W., Minhas, S. & Ward, M.D. (2017) JCR — Firewall? or Wall on Fire? Conflict Contagion and the Role of Ethnic Networks | Data available: https://journals.sagepub.com/doi/full/10.1177/0022002715603452 GBME model — Bayesian, MCMC, no  ρ  |
| Gade et al. (2019) JCR — Networks of Cooperation (rebel alliances) | Data available: https://journals.sagepub.com/doi/full/10.1177/0022002719826234 use AME models. There is no ρ in this paper |
| Aidt & Leon-Ablan (2022) BJPS — Diffusion in Social Unrest (Swing Riots) | No time variation |
| Gade et al. (2019) JPR — Fratricide in Rebel Movements | No time variation |
| Franzese & Hays (2017) PA — Spatial Econometric Models of Cross-Sectional Interdependence | Methodological paper |
| Cook, Hays & Franzese (2022) APSR — STADL Up! The Spatiotemporal Autoregressive Distributed Lag Model for TSCS Data Analysis | Reanalysis of Acemoglu et al. (2008) on Development and Democracy |
---already done before
| Beck, Gleditsch & Beardsley (2006) ISQ — Space Is More than Geography (Table 2: Directed Export Flows) | Completed by Deki. Very sparse network |
| Wibbels & Ahlquist (2011) ISQ — Trade, Development, and Social Insurance  |  No time variation |
| Hinkle (2014) AJPS — Federal Courts and State Policy Diffusion | No Wy |
| Genovese, Kern & Martin (2017) ISQ — Policy Alteration | All nodes fully connected, no CLEAN blocks |
| Desmarais & Uppala (2023) PA — Contagion, Confounding, Causality | Methodological paper |
| Malang et al. (2019) BJPS — Networks and Social Influence (EU legislatures) | No Wy |
| Chaney (2023) AJPS — Policy Networks Across Political Systems | No Wy |

### No data (Data availability: No data)
| Paper | Status |
| --- | --- |
| Linos (2011) AJPS — Diffusion through Democracy | Data available: https://onlinelibrary.wiley.com/doi/10.1111/j.1540-5907.2011.00513.x but replication data link broken |
| Jahn (2006) IO — Globalization as 'Galton's Problem': The Missing Link in the Analysis of Diffusion Patterns | Data available: No data |
| Pitlik (2007) PC — A Race to Liberalization? Diffusion of Economic Policy Reform among OECD-Economies | Data available: No data |
| Gleditsch & Ward (2006) IO — Diffusion and the International Context of Democratization | Data available: No data |
| Simmons, Dobbin & Garrett (2006) IO — Introduction: The International Diffusion of Liberalism | Data available: No data |
| Flores (2011) CMPS — Alliances as Contiguity in Spatial Models of Military Expenditures | Data available: No data|
| Bormann & Winzen (2016) EJPR — The Contingent Diffusion of Parliamentary Oversight Institutions in the EU | https://onlinelibrary.wiley.com/doi/10.1111/1475-6765.12149 no data |
| Beardsley (2011) JoP — Peacekeeping and the Contagion of Armed Conflict | Data available: No replication data |
| Simmons & Elkins (2004) APSR — Globalization of Liberalization | No replication code |
| Maves & Braithwaite (2013) JoP — Autocratic Institutions and Civil Conflict Contagion | Data available: No replication data |
| Shaw et al. (TBD) — Show Me the Money: Interjurisdictional Political Competition and Fiscal Extraction in China | No data |
| Gleditsch & Rivera (2015) JCR — The Diffusion of Nonviolent Campaigns | Data available: no |
| Kahn-Nisser (2015) JEPP — The Hard Impact of Soft Co-ordination | Data available: no |
| Plümper & Neumayer (2009) EJPR — Model Specification in the Analysis of Spatial Dependence | Data available: https://onlinelibrary.wiley.com/doi/full/10.1111/j.1475-6765.2009.01900.x failed to open the liink |
| Senninger (2019) WEP — Institutional Change in Parliament through Cross-Border Partisan Emulation | Data available: Applicable but no data |
| Harbers (2016) ES — Spatial Effects and Party Nationalization: The Geography of Partisan Support in Mexico | Data available: Applicable but no data |
| Roumanias, Rori & Georgiadou (2022) ES — Far-Right Domino: Towards an Integrated Framework of Political Contagion | Data available: https://www.sciencedirect.com/science/article/pii/S026137942200004X#da1 Data will be made available on request |
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
