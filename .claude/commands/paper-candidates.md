# CLEAN Replication Candidate Papers

## Purpose

This command is an active paper-finding workflow. When invoked, **immediately execute the following default sweep** without waiting for further instruction:

1. Run **Step B** (keyword search via Semantic Scholar, SSRN, Harvard Dataverse API)
2. Run **Step C** (Harvard Dataverse file-name search)
3. Run **Step D** (author page sweep via Semantic Scholar author profiles)
4. **Screen every candidate found** against the 4-gate checklist (Section 2)
5. Add passing papers to "To Investigate"; log failing papers in "Disqualified" with gate number and reason
6. Append a row to the Search Log (Section 7)

> **Note on Step A:** Google Scholar blocks automated requests — skip it in the automated sweep. Run Step A manually in a browser using the seed papers listed in Section 4.

**What CLEAN needs from a paper:**
- An explicit spatially lagged dependent variable **Wy** in the model (SAR/spatial lag specification)
- A genuine **n×n** adjacency, connectivity, or weight matrix **W** encoding network ties between units
- Publicly available **replication files** (Harvard Dataverse, GitHub, author website, or journal appendix)

**Time period:** 2000–present; **prioritize 2010+** for replication file availability.

---

## Section 2: Screening Checklist

Apply all 4 gates to every paper before adding it to any candidate table. Reject at the first failed gate and log it in the **Disqualified** table.

| Gate | Question | Pass condition |
| --- | --- | --- |
| 1 | **Has explicit Wy?** | Model includes a spatially lagged DV; ρ (or equivalent) is estimated |
| 2 | **W is genuine n×n network?** | W is an adjacency, contiguity, or connectivity matrix — NOT a constructed exposure/similarity measure (e.g., shared vote-loss weights, co-sponsorship similarity scores) |
| 3 | **Network non-trivially structured?** | Density roughly 1%–90%; not fully connected, not near-empty |
| 4 | **Replication files available?** | Files on Harvard Dataverse, author website, GitHub, or journal appendix |

---

## Section 3: Journal Coverage

**Tier 1** — Top IR/CP/methods journals (search first; highest replication discipline):
APSR, AJPS, JOP, BJPS, IO, ISQ, JCR, JPR, CPS, WP, PSRM, Political Analysis

**Tier 2** — Broader AP / Public Administration journals (search after Tier 1; expect fewer replication files, especially pre-2015):
PRQ, Political Geography, CMPS, JPART, American Politics Research, State Politics & Policy Quarterly, Public Administration Review

---

## Section 4: Search Playbook

Execute steps A–D in order. Log each sweep in the Search Log (Section 7).

### Step A — Citation-chain from milestone papers (highest yield)

Search Google Scholar / Semantic Scholar "Cited by" for these seeds. Filter citing papers by: Tier 1 journal, year 2008–present, "spatial lag" or "SAR" or "Wy" in abstract/text.

**IR seeds** (surface IR follow-ups):
- Gleditsch & Ward (2000) ISQ — "War and Peace in Space and Time"
- Buhaug & Gleditsch (2008) ISQ — "Contagion or Confusion?"
- Beck, Gleditsch & Beardsley (2006) ISQ — "Space Is More than Geography"

**CP / AP / PA seeds** (surface comparative politics, American politics, public administration follow-ups):
- Franzese & Hays (2007) *Political Analysis* — "Spatial Econometric Models of Cross-Sectional Interdependence" (canonical methods paper cited broadly across CP and AP)
- Desmarais & Cranmer (2012) *Political Analysis* — network models in political science (cited across CP and AP)

### Step B — Keyword search across databases

Search: Google Scholar, Semantic Scholar, JSTOR, Scopus, SSRN

- **Primary terms:** `"spatial lag" OR "spatial autoregressive" OR "SAR model"` + `"political"`
- **Secondary terms:** `"diffusion" OR "contagion"` + `"network"` + `"replication"`
- Narrow by Tier 1 journals first, then Tier 2; year 2008–2026

### Step C — Replication-file-first search on Harvard Dataverse

Search Harvard Dataverse for datasets containing files named `W`, `adj`, `weight_matrix`, `connectivity`. Filter by political science. Find the associated paper, then check if it uses SAR/Wy.

### Step D — Author-level follow-up

Check publication lists of prolific spatial-methods scholars: K.S. Gleditsch, M.D. Ward, Franzese, Hays, Desmarais, Minhas, Dorff, Wimpy, Whitten, Williams. Any paper with "spatial" or "network" in the title is a warm lead.

---

## Section 5: LLM Search Prompt Template

Paste into Claude, Perplexity, or ChatGPT for systematic candidate generation:

```
I am working on a research project applying the CLEAN method to political science papers.
CLEAN requires papers that:
(1) Use a spatial lag model (SAR), where Wy (the spatially lagged dependent variable) appears explicitly in the model
(2) Have a genuine n×n adjacency, connectivity, or weight matrix W encoding network ties between units
(3) Have publicly available replication files (Harvard Dataverse, GitHub, author website, or journal appendix)

Please search [JOURNALS: see list below] for papers published [YEAR RANGE: 2010–2026] in the subfields of comparative politics, international relations, and public administration.

Journals to search: APSR, AJPS, JOP, BJPS, IO, ISQ, JCR, JPR, CPS, WP, PSRM, PRQ, Political Geography, CMPS, JPART [adjust as needed]

For each candidate paper, explain:
- What the W matrix represents (geographic contiguity? trade ties? shared membership?)
- Whether the paper explicitly reports a spatial lag coefficient (ρ or equivalent)
- Whether replication files are likely available (based on journal policy and year)

Do NOT suggest papers where W is a constructed exposure measure (e.g., weighted vote shares, co-sponsorship similarities) rather than a genuine network adjacency matrix.
```

---

## Section 6: Tracking Tables

### Already Replicated

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

---

### Ready to be Replicated (checked by Jack)
| Paper | Status |
| --- | --- |
| Desmarais & Uppala (2023) PA — Contagion, Confounding, Causality | Checked by Jack |
| Malang et al. (2019) BJPS — Networks and Social Influence (EU legislatures) | Checked by Jack |
| Dorff et al. (2023) BJPS — Network Competition and Civilian Targeting | Checked by Jack |
| Aidt & Leon-Ablan (2022) BJPS — Diffusion in Social Unrest (Swing Riots) | Checked by Jack |
| Garcia & Wimpy (2016) PSRM — Does Information Lead to Emulation? | Checked by Jack |
| Ruggeri et al. (2017) PSRM — Counterbalancing, Spatial Dependence, Peer Effects | Checked by Jack |
| Lindstädt et al. (2017) PSRM — Diffusion in Congress | Checked by Jack |
| Metternich et al. (2017) JCR — Firewall? Or Wall on Fire? | Checked by Jack |
| Gade et al. (2019) JCR — Networks of Cooperation (rebel alliances) | Checked by Jack |
| Weidmann (2015) JPR — Communication Networks and Ethnic Conflict | Checked by Jack |
| Gade et al. (2019) JPR — Fratricide in Rebel Movements | Checked by Jack |
| Sommerer & Tallberg (2019) IO — Diffusion Across International Organizations | Checked by Jack |

---

### Strong Candidates

- **[[W]hat Lies Beneath: Using Latent Networks to Improve Spatial Predictions](https://doi.org/10.1093/isq/sqac012)**
  — Dorff, Gallop & Minhas (2022, *International Studies Quarterly*)
  Network: country-to-country conflict spillover | W: geographic, shared groups, institutional ties (multiple competing matrices)
  Homophily: conflict spreads via observed ties AND unobserved shared conditions (ethnic composition, state capacity)
  Data: Uppsala Conflict Data Project (UCDP) — publicly accessible
  Note: paper itself proposes unsupervised latent network learning — CLEAN's SBM approach aligns perfectly; high theoretical fit

---
### Moderate Candidates

- [**Historical Border Changes, State Building, and Contemporary Trust in Europe**](https://doi.org/10.1017/S0003055421001040)
  — Abramson, Carter & Ying (2022, *American Political Science Review*)
  Network: geographic locations (NUTS3-level, European regions) | W: distance-based
  Homophily: border regions and neighboring areas both experienced similar border shocks AND have correlated trust
  Data: European Social Survey (ESS) + historical border data — excellent accessibility
  Note: individual-level outcome nested in geographic units; requires aggregation step before CLEAN

- [**Show Me the Money: Interjurisdictional Political Competition and Fiscal Extraction in China**](TBD)
  — Shaw et al. (year TBD)
  Network: Chinese provincial/municipal network | W: administrative hierarchy / geographic contiguity
  Homophily: provinces in same region face similar extraction pressure AND share development levels
  Data: Chinese government statistics — partial accessibility; verify before committing

---

### To Investigate (intake queue)

> Papers flagged as likely candidates but not yet screened. Add new entries here during search sweeps, then promote to Strong/Moderate after screening, or move to Disqualified if a gate fails.

- Beck, Gleditsch & Beardsley (2006) JoP — "Space is More than Geography" (foundational; check if substantive application included)
- Franzese & Hays (2007) Political Analysis — "Spatial Econometric Models of Cross-Sectional Interdependence" (methods paper; check for application)

**Added 2026-03-17 sweep (Steps B, C, D via Semantic Scholar + Harvard Dataverse):**
**9 more papers **

- **Neumayer & Plümper (2012) CPS** — "Conditional Spatial Policy Dependence: Theory and Model Specification." *Comparative Political Studies* 45(7): 819–849. W: row-standardized country contiguity/distance matrix; cross-national policy DV; rho estimated. Replication: https://doi.org/10.7910/DVN/UVSMOV
- **Steinwand (2015) IO** — "Compete or Coordinate? Aid Fragmentation and Lead Donorship." *International Organization* 69(2). W: donor-country co-presence matrix (n×n among donors per recipient); explicit SAR with rho. Replication: https://doi.org/10.7910/DVN/23970
- **Wibbels & Ahlquist (2011) ISQ** — "Trade, Development, and Social Insurance." *International Studies Quarterly* 55(1): 125–149. W: minimum-distance country matrix (mdd1982.csv); social insurance DV; rho estimated. Replication: https://doi.org/10.7910/DVN/L99P1O
- **Schleiter, Böhmelt, Ezrow & Lehrer (2021) WP** — "Social Democratic Party Exceptionalism and Transnational Policy Linkages." *World Politics* 73(3). W: country-to-country matrix (geographic/trade); party policy position DV. **Action needed:** read `World Politics Dofile.do` to confirm SAR (not SLX/SEM) and verify W type. Replication: https://doi.org/10.7910/DVN/DYWBRH
- **Cook, Hays & Franzese (2022) APSR** — "STADL Up! The Spatiotemporal Autoregressive Distributed Lag Model for TSCS Data Analysis." *American Political Science Review* 116(3). Methods paper with accountability empirical application. **Action needed:** read R scripts to confirm empirical W and that Wy/rho are clearly reported. Replication: https://doi.org/10.7910/DVN/DBMJQZ
- **Betz, Cook & Hollenbach (2021) PA** — "Bias from Network Misspecification Under Spatial Dependence." *Political Analysis* 29(2). Uses KP2012 benchmarking data empirically. **Action needed:** read application script to confirm outcome variable and W density. Replication: https://doi.org/10.7910/DVN/ADIFOV
- **Franzese, Hays & Cook (2016) PSRM** — "Spatial- and Spatiotemporal-Autoregressive Probit Models of Interdependent Binary Outcomes." *Political Science Research and Methods* 4(1). W: African country contiguity matrix (hb_ksg_contig_W.csv); binary conflict DV. **Note:** binary DV — verify CLEAN compatibility with probit SAR before committing. Replication: https://doi.org/10.7910/DVN/28322
- **Franzese & Hays (2006) EUP** — "Strategic Interaction among EU Governments in Active-Labor-Market Policymaking." *European Union Politics* 7(2). W: EU country interaction matrix (ALM_W_IRE.tab); rho estimated for labor market spending. Replication: https://doi.org/10.7910/DVN/FEA4T2 **Note: year 2006 (pre-2010 priority cutoff); include only if needed.**
- **Franzese & Hays (2008) CPS** — "Interdependence in Comparative Politics." *Comparative Political Studies* 41(4/5). W: country adjacency/trade matrix; reanalysis of tax competition data. Replication: https://doi.org/10.7910/DVN/C1O8HS **Note: year 2008 (pre-2010 priority cutoff); include only if needed.**

---

### Disqualified

> Papers screened and rejected. Log here to prevent re-investigating across sweeps.
7 papers
| Paper | Gate failed | Reason | Checked by |
| --- | --- | --- | --- |
| Beck, Gleditsch & Beardsley (2006) ISQ — Table 2: Directed Export Flows | Gate 3 | Very sparse network | Deki |
| Montgomery & Nyhan (2017) JoP — Congressional Staff Networks | Gate 3 | Extremely sparse networks (all-staff ≈ 0.115%, senior-staff ≈ 0.025%) | Deki, Insu |
| Williams & Whitten (2014) AJPS — Don't Stand So Close to Me | Gate 3 | CLEAN blocks explain only ~2.2% of spatial lag; insufficient network structure | Deki |
| Hinkle (2014) AJPS — Federal Courts and State Policy Diffusion | Gate 1 | No Wy in model | Zihuan |
| Genovese, Kern & Martin (2017) ISQ — Policy Alteration | Gate 3 | All nodes fully connected; no block structure detectable | Zihuan |
| How Parties React to Voter Transitions (year/journal TBD) | Gate 2 | W encodes co-exposure/vote-loss weights, not genuine network adjacency | Jack |
| van de Wardt et al. (2023) — Contagion from abroad: Party entry in Western Europe | Gate 1 | Outcome is party entry (event history), not a SAR with explicit Wy and rho | Claude sweep 2026-03-17 |
| Gilardi, Shipan & Wüest (2021) AJPS — Policy Diffusion: The Issue-Definition Stage | Gate 1 | Uses structural topic modeling (STM), not SAR; spatial weight matrix is used for predictors only, not as an estimating model | Claude sweep 2026-03-17 |
| Monogan & Hood — Contagious Republicanism in Louisiana, 1964–2014 | Gate 1 | SLX model (WX only), not SAR; no spatially lagged DV and no rho estimated | Claude sweep 2026-03-17 |
| Jackson & Monogan (2018) PSRM — The Fifty American States in Space and Time | Gate 1 | Uses CAR/ICAR Bayesian spatial error model, not SAR; no explicit Wy term or rho | Claude sweep 2026-03-17 |
| Franzese, Hays & Kachi (2012) PA — Modeling History Dependence in Network-Behavior Coevolution | Gate 2 | W is endogenously determined (network-behavior coevolution); CLEAN requires an exogenous W | Claude sweep 2026-03-17 |
| Betz, Cook & Hollenbach (2018) PSRM — Spatial Interdependence and Instrumental Variable Models | Gate 4 | Methods paper; empirical applications use economics datasets (oil wealth, Ashraf & Galor), not published political science SAR papers in target journals | Claude sweep 2026-03-17 |
| Neumayer, Laroze & Plümper (2021) — Covid-19 Spatial Contagion in England | Gate 4 | Published in Social Science & Medicine, not a target political science journal | Claude sweep 2026-03-17 |

---

## Section 7: Search Log

| Date | Who | Source | Terms / Strategy | Papers found | Papers added |
| --- | --- | --- | --- | --- | --- |
| 2026-03-03 | Zihuan | Project exploration (existing folders + candidate folder) | N/A | 4 candidates identified | 4 (to Strong/Moderate) |
| 2026-03-17 | Claude (automated) | Semantic Scholar API + Harvard Dataverse API | Steps B, C, D: "spatial lag OR spatial autoregressive OR SAR model political"; Dataverse file search (W_matrix, weight_matrix, adjacency, spatial lag); author sweep (Wimpy, Williams, Whitten, Desmarais, Minhas) | 17 papers screened | 9 to Investigate, 7 to Disqualified |
