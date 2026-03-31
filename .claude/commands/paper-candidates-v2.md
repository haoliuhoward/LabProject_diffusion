---
name: clean-replication-candidate-finder
description: >
  Active paper-finding workflow for the CLEAN project. Use this skill whenever
  the user says "CLEAN project", "replication candidate", "find more papers for
  CLEAN", "spatial lag replication", or asks to search for SAR/spatial-lag papers
  with replication files. The skill runs a prioritized search sweep (citation
  graph → author sweep → keyword search → Dataverse), automatically skips all
  52 already-known papers via a built-in exclusion list, and screens every new
  candidate through the 4-gate checklist before adding it to the pipeline.
  Always invoke this skill for any CLEAN paper-search task — do not improvise
  the workflow from scratch.
---

# CLEAN Replication Candidate Finder

## What CLEAN needs from a paper
- An explicit **spatially lagged dependent variable Wy** (SAR / spatial lag specification)
- A genuine **n×n** adjacency / connectivity / weight matrix **W** encoding network ties
- Publicly available **replication files** (Harvard Dataverse, GitHub, author website, or journal appendix)

**Time period:** 2000–present; **prioritize 2010+** for replication file availability.

---

## Section 1 — 4-Gate Screening Checklist

Run every new candidate through all four gates in order. Fail at the first gate that is not met.

| Gate | Criterion | Fail reason to log |
|------|-----------|-------------------|
| G1 | Paper uses a spatially lagged DV (Wy) in its main model | "No Wy / not SAR spec" |
| G2 | W matrix encodes genuine network ties between units (not just co-exposure or full connectivity) | "W not genuine network" |
| G3 | Replication files are publicly available | "No data" |
| G4 | W matrix has sufficient density (not extremely sparse, e.g. <0.5% density) | "Network too sparse" |

> **Note on G4:** Sparsity thresholds from completed replications — Montgomery & Nyhan (2017) failed at ~0.025–0.115% density; Williams & Whitten (2014) borderline. Flag papers near the threshold as "Ambiguous — check density."

---

## Section 2 — Exclusion List (52 papers — skip these in all searches)

Full list is in `.claude/commands/clean-exclusion-list.md`. Read that file when screening candidates. Do not re-add any paper already listed there.

---

## Section 3 — Search Workflow (Token-Efficient Order)

> **Always run steps in this order.** Stop early if you hit 20+ new screened candidates.

### Step 1 — Citation Graph (HIGHEST PRIORITY, lowest token cost)

Use the Semantic Scholar API to pull references and citations for seed papers.
Seed from the **14 Completed** papers first, then the **10 TBD Data Available** papers.

```
GET https://api.semanticscholar.org/graph/v1/paper/{paper_id}/references
    ?fields=title,authors,year,externalIds,openAccessPdf
GET https://api.semanticscholar.org/graph/v1/paper/{paper_id}/citations
    ?fields=title,authors,year,externalIds,openAccessPdf
```

- Papers appearing in ≥2 citation neighborhoods = high-priority candidate
- Check each result against Section 2 exclusion list **before** screening
- Log: `[CitGraph] Found via citation of {source_paper}`

### Step 2 — Author Profile Sweep (HIGH PRIORITY)

Extract all unique authors from the 14 Completed papers. For each author:

```
GET https://api.semanticscholar.org/graph/v1/author/search?query={author_name}
GET https://api.semanticscholar.org/graph/v1/author/{author_id}/papers
    ?fields=title,year,externalIds,openAccessPdf
```

Focus on authors known to work in spatial econometrics / network diffusion:
Beck, Gleditsch, Beardsley, Nyhan, Montgomery, Franzese, Hays, Cook, Böhmelt, Ruggeri, Williams, Whitten, Wimpy, Kinne, Gannon, Olar, Desmarais

- Log: `[AuthorSweep] Found via author profile of {author_name}`

### Step 3 — Keyword Search (MEDIUM PRIORITY — use targeted sub-niches only)

Run only queries targeting gaps not covered by your 52 papers. Avoid broad sweeps.
Suggested targeted queries for Semantic Scholar and SSRN:

| Gap area | Query |
|----------|-------|
| Health/aid diffusion | "spatial lag bilateral aid W matrix replication" |
| Migration/trade networks | "SAR migration network adjacency matrix replication data" |
| Conflict networks | "spatial autoregressive rebel network Wy replication" |
| Electoral/party diffusion | "spatial lag party competition electoral network Dataverse" |
| Regulatory diffusion | "spatial dependence regulatory policy W matrix replication files" |

```
GET https://api.semanticscholar.org/graph/v1/paper/search
    ?query={query}&fields=title,authors,year,externalIds,openAccessPdf&limit=20
```

- Log: `[KeywordSearch] Query: "{query}"`

### Step 4 — Harvard Dataverse File-Name Search (LOWEST PRIORITY — run last)

Search for replication archives containing spatial weight matrix files.

```
GET https://dataverse.harvard.edu/api/search
    ?q=spatial+weight+matrix+replication&type=file&per_page=20
```

Target filenames: `W.csv`, `weight_matrix.*`, `adjacency.*`, `spatial_weights.*`, `*.gwt`, `*.gal`

- Log: `[Dataverse] Found via file-name search`

> **Note on Step A (Google Scholar):** Google Scholar blocks automated requests. Run manually in browser using seed queries from Step 3. Not part of automated sweep.

---

## Section 4 — Screening & Logging

### For each new candidate found:

1. Check exclusion list (Section 2) — if match found, skip immediately
2. Run 4-gate checklist (Section 1)
3. **Find replication link** (do this before logging, even if gate check is still in progress):
   - Search Harvard Dataverse: `https://dataverse.harvard.edu/dataverse/harvard?q={title}`
   - Check journal page for supplementary materials / replication appendix
   - Check author's personal/institutional website
   - Check GitHub (search `{author lastname} {keyword} replication`)
   - If found → record the exact URL
   - If not found → record `No data`
4. Route result:
   - **Pass all 4 gates + link found** → add to Section 5 "New Candidates" with replication URL
   - **Pass all 4 gates + no link found** → add to Section 5 "New Candidates" with `No data`
   - **Fail G1 or G2** → add to Section 6 Disqualified with gate number and reason
   - **Fail G3 (no data confirmed)** → add to Section 5 "New Candidates" with `No data` (keep visible — data may appear later)
   - **Fail G4 (too sparse)** → add to Section 6 Disqualified
   - **Ambiguous G4** → add to Section 5 with flag `⚠️ Check density before replication`

### Search Log entry format (append to Section 7):
```
| {date} | {step} | {query/seed} | {candidates found} | {passed} | {failed} | Notes |
```

---

## Section 5 — New Candidates (output list)

> **This is the primary output of every search sweep.**
> Every paper that passes gates G1+G2 (and is not in the Section 2 exclusion list) belongs here,
> regardless of whether replication data was found. Papers with `No data` stay visible — data may
> appear later or can be requested from authors.

**Format rule:** Match this exact column layout —

| Paper | Replication Files |
|-------|------------------|
| Author(s) (Year) Journal — Title | Data Available: {URL} |
| Author(s) (Year) Journal — Title | No data |
| Author(s) (Year) Journal — Title | ⚠️ Check density before replication — Data Available: {URL} |

---

### New Candidates Found

| Paper | Replication Files |
|-------|------------------|
| Doten-Snitker, K. (2024) CPS — The Diffusion of Exclusion: Medieval Expulsions of Jews | Data Available: https://doi.org/10.7910/DVN/SCJL8I |
| Metternich, N.W. & Wucherpfennig, J. (2020) International Interactions — Strategic Rebels: A Spatial Econometric Approach to Rebel Fighting Durations in Civil Wars | Data Available: https://doi.org/10.7910/DVN/XUVHCH |
| Polo, S.M.T. (2020) JCR — How Terrorism Spreads: Emulation and the Diffusion of Ethnic and Ethnoreligious Terrorism | No data |
| Böhmelt, T. & Bove, V. (2019) JPR — Does Cultural Proximity Contain Terrorism Diffusion? | No data |
| Aidt, T., León, G. & Satchell, M. (2021) JoP — The Social Dynamics of Collective Action: Evidence from the Diffusion of the Swing Riots, 1830–31 | Data Available: https://doi.org/10.7910/DVN/VIXZD1 |
| Böhmelt, T., Ezrow, L. & Lehrer, R. (2016) APSR — Party Policy Diffusion | No data (APSR requires replication — check Cambridge Core supplementary) |
| Böhmelt, T. (2016) JPR — The Importance of Conflict Characteristics for the Diffusion of International Mediation | No data |
| Metternich, N.W., Minhas, S. & Ward, M.D. (2015) JCR — Firewall? or Wall on Fire? Conflict Contagion and the Role of Ethnic Networks | No data |
| Goodliffe, J. & Hawkins, D. (2015) JCR — Dependence Networks and the Diffusion of Domestic Political Institutions | No data |
| Forsberg, E. (2014) International Interactions — Transnational Transmitters: Ethnic Kinship Ties and Conflict Contagion 1946–2009 | Data Available: https://doi.org/10.7910/DVN/25769 |
| Ward, H. & John, P. (2013) PSRM — Competitive Learning in Yardstick Competition: Testing Models of Policy Diffusion With Performance Data | Data Available: https://doi.org/10.7910/DVN/B4VBVM |
| Flores, A. (2011) CMPS — Alliances as Contiguity in Spatial Models of Military Expenditures | No data |
| Greenhill, B. (2010) ISQ — The Company You Keep: International Socialization and the Diffusion of Human Rights Norms | ⚠️ Check density before replication — Data Available: https://doi.org/10.7910/DVN/40FMWG |
| Oneal, J.R., Russett, B. & Berbaum, M.L. (2003) ISQ — Causes of Peace: Democracy, Interdependence, and International Organizations, 1885–1992 | No data |

---

### Pending Verification — G1/G2 Uncertain (from 2026-03-31 sweep)

These 16 papers passed keyword + pre-filter screening but abstracts were insufficient to confirm G1 or G2. Read the paper before routing to New Candidates or Disqualified. Key question per paper noted below.

| Paper | DOI | Check |
|-------|-----|-------|
| Beardsley, K. (2011) JoP — Peacekeeping and the Contagion of Armed Conflict | 10.1017/s0022381611000764 | G2: is W geographic contiguity or mission-network? |
| Clay, K. & Owsiak, A.P. (2015) JoP — The Diffusion of International Border Agreements | 10.1086/683987 | G1+G2: confirm SAR spec and W type |
| Böhmelt, T. (2014) CMPS — The Spatial Contagion of International Mediation | 10.1177/0738894214544615 | G2: geographic proximity vs. conflict-similarity W |
| Böhmelt, T. & Freyburg, T. (2014) WEP — Diffusion of Compliance in the 'Race towards Brussels?' | 10.1080/01402382.2014.943523 | G2: confirm W is trade/org linkages not geographic |
| Baccini, L. & Dür, A. (2011) BJPS — The New Regionalism and Policy Interdependence | 10.1017/s0007123411000238 | G1: confirm SAR not hazard model; G2: trade competition W |
| Böhmelt, T. & Bove, V. (2019) EJPR — How Migration Policies Moderate the Diffusion of Terrorism | 10.1111/1475-6765.12339 | G2: confirm migration flow W is genuine network |
| Goldring, E. & Greitens, S.C. (2019) CPS — Rethinking Democratic Diffusion: Bringing Regime Type Back In | 10.1177/0010414019852701 | G1+G2: confirm SAR and W type (regime networks?) |
| Senninger, R. (2019) WEP — Institutional Change in Parliament through Cross-Border Partisan Emulation | 10.1080/01402382.2019.1578095 | G1: confirm SAR; data found: https://doi.org/10.7910/DVN/BKADA6 |
| Simmons, B.A., Lloyd, P. & Stewart, B. (2018) IO — The Global Diffusion of Law: Human Trafficking | 10.1017/s0020818318000036 | G1+G2: confirm SAR and W type |
| Bormann, N. & Winzen, T. (2016) EJPR — The Contingent Diffusion of Parliamentary Oversight Institutions in the EU | 10.1111/1475-6765.12149 | G1: confirm SAR; G2: inter-parliamentary network W looks genuine |
| Linos, K. (2011) AJPS — Diffusion through Democracy | 10.1111/j.1540-5907.2011.00513.x | G1: confirm SAR; G2: elite/trade network W |
| Brooks, S.M. & Kurtz, M.J. (2012) IO — Paths to Financial Policy Diffusion: Statist Legacies in Latin America | 10.1017/s0020818311000385 | G1: confirm SAR not qualitative; G2: trade/financial W |
| Elkink, J.A. (2011) CPS — The International Diffusion of Democracy | 10.1177/0010414011407474 | G1+G2: confirm SAR and W type |
| Roumanias, C., Rori, L. & Georgiadou, V. (2022) Electoral Studies — Far-Right Domino: Political Contagion | 10.1016/j.electstud.2022.102442 | G1+G2: no abstract available — read paper |
| Kahn-Nisser, S. (2015) JEPP — The Hard Impact of Soft Co-ordination: Emulation and Convergence | 10.1080/13501763.2015.1022205 | G1+G2: no usable abstract — read paper |
| Pitlik, H. (2007) Public Choice — A Race to Liberalization? Diffusion of Economic Policy Reform among OECD | 10.1007/s11127-006-9140-y | G1+G2: no abstract — read paper |

---

## Section 6 — Disqualified Log

*Append failing papers here with gate number.*

| Paper | Gate Failed | Reason |
|-------|------------|--------|
| Zhukov & Stewart (2012) ISQ — Choosing Your Neighbors: Networks of Diffusion | G1 | Methods paper on W specification; no substantive SAR DV |
| Lane (2016) JoP — The Intrastate Contagion of Ethnic Civil War | G2 | W based on geographic/ethnic location, not genuine network ties |
| Phillips (2014) CMPS — Civil War, Spillover and Neighbors' Military Spending | G2 | Geographic contiguity W |
| Bell, Clay & Murdie (2012) JoP — Neighborhood Watch: Spatial Effects of Human Rights INGOs | G2 | Geographic "next door" W |
| Gleditsch & Rivera (2015) JCR — The Diffusion of Nonviolent Campaigns | G2 | Geographic clustering W |
| Maves & Braithwaite (2013) JoP — Autocratic Institutions and Civil Conflict Contagion | G2 | Geographic contiguity W |
| Black (2013) JPR — When Have Violent Civil Conflicts Spread? | G2 | Geographic contiguity W |
| Kathman (2011) JCR — Civil War Diffusion and Regional Motivations for Intervention | G2 | Geographic/regional W |
| Kathman (2010) ISQ — Civil War Contagion and Neighboring Interventions | G2 | Geographic contiguity W |
| Braithwaite (2010) JPR — Resisting Infection: How State Capacity Conditions Conflict Contagion | G2 | Geographic contiguity W |
| Linebarger (2015) International Interactions — Civil War Diffusion and Militant Groups | G2 | Geographic contiguity W |
| Braithwaite, Braithwaite & Kucik (2015) JPR — Conditioning Effect of Protest History on Emulation | G2 | Geographic W |
| Sarıgil (2020) JPR — A Micro-Level Analysis of the Contagion Effect: Kurdish Conflict | G2 | Geographic W |
| Kıbrıs (2021) JPR — Geo-Temporal Evolution of Violence in Civil Conflicts | G2 | Geographic W |
| Gomez & Winger (2024) JPR — Third-Party Countries in Cyber Conflict: Conflict Spillover | G2 | Geographic W |
| Crabtree, Kern & Pfaff (2018) ISQ — Mass Media and the Diffusion of Collective Action | G2 | Media broadcast radius = geographic W |
| Glasius, Schalk & De Lange (2020) ISQ — Illiberal Norm Diffusion: NGO Restrictions | G2 | Regional/geographic environment W |
| Franzese & Hays (2007) PA — Spatial Econometric Models of Cross-Sectional Interdependence | G1 | Already excluded; methods paper |
| Franzese & Hays (2008) CPS — Interdependence in Comparative Politics | G1 | Already excluded; methods paper |
| Garcia & Wimpy (2014) PSRM — Does Information Lead to Emulation? | G1 | Already excluded |
| Neumayer & Plümper (2009) EJPR — Model Specification in the Analysis of Spatial Dependence | G1 | Methods paper; no substantive SAR DV |
| Neumayer & Plümper (2010) IO — Spatial Effects in Dyadic Data | G1 | Methods paper |
| Kim, Liu & Desmarais (2022) PSRM — Spatial Modeling of Dyadic Geopolitical Interactions | G1 | Methods/dyadic model paper |
| Juhl (2018) PA — Measurement Uncertainty in Spatial Models | G1 | Methods paper |
| Harbers & Ingram (2017) PA — Geo-Nested Analysis | G1 | Methods paper |
| Ambrosio (2010) ISP — Constructing a Framework of Authoritarian Diffusion | G1 | Conceptual/framework paper; no empirical SAR |
| Solingen (2012) ISQ — Of Dominoes and Firewalls | G1 | ISQ Presidential Address; conceptual only |
| Jordana, Levi-Faur & Fernández-i-Marín (2011) CPS — Global Diffusion of Regulatory Agencies | G1 | Hazard/duration model; no SAR |
| Elkins, Guzmán & Simmons (2006) IO — Competing for Capital: Diffusion of Bilateral Investment Treaties | G1 | Event history model; no SAR |
| Jahn (2006) IO — Globalization as 'Galton's Problem' | G1 | Methods/conceptual paper |
| Simmons, Dobbin & Garrett (2006) IO — Introduction: The International Diffusion of Liberalism | G1 | Review/introduction; no empirical SAR |
| Magee & Massoud (2022) International Interactions — Diffusion of Protests in the Arab Spring | G1 | Event count model; no SAR |
| Brooks, Cunha & Mosley (2014) ISQ — Categories, Creditworthiness, and Contagion | G1 | Investor rating model; no SAR with Wy |
| Murdoch & Sandler (2002) JCR — Economic Growth, Civil Wars, and Spatial Spillovers | G2 | Geographic neighbors W |

---

## Section 7 — Search Log

| Date | Step | Query / Seed | Candidates | Passed | Failed | Notes |
|------|------|-------------|-----------|--------|--------|-------|
| 2026-03-31 | Step 1 (CitGraph) | Gleditsch & Ward 2000; Buhaug & Gleditsch 2008; Beck/Gleditsch/Beardsley 2006 — citations direction only | 1139 unique → 69 keyword-filtered → 48 after pre-filter | 14 (G1+G2 pass) | 34 (18 pre-filter + 16 abstract screen) | 16 additional CHECK papers need manual G1/G2 verification |

---

## Section 8 — Final Output Instruction

After every search sweep, render a clean standalone list of **all new candidates** (Section 5 contents only — do not include any of the 52 papers from Section 2). Use this exact format:

```
## CLEAN Replication Candidates — New Finds
*(Not including the 52 already-known papers)*

| Paper | Replication Files |
|-------|------------------|
| ... | Data Available: {URL} |
| ... | No data |
```

Rules for this output:
- One row per paper, sorted by journal then year (newest first within each journal)
- If a URL was found, write `Data Available: {full URL}`
- If no URL was found, write `No data`
- If density is ambiguous, prepend `⚠️ ` to the replication files cell
- Do **not** include papers from the Section 2 exclusion list, even as context
- Do **not** include disqualified papers (Section 6)
- This list should be directly copy-pasteable into the project tracker

---

## Section 9 — Quick Reference: CLEAN Works / Doesn't Work

**CLEAN likely works when:**
- W encodes social/political network similarity (shared attributes, alliances, trade ties)
- High R² between CLEAN blocks and Wy (target: R² > 0.4)
- Network has moderate density (not near-zero, not fully connected)

**CLEAN likely fails when:**
- W is geographic contiguity only (direct spatial link, not proxy of similarity)
- Network is extremely sparse (<0.5% density)
- All nodes fully connected (no block structure possible)
- W encodes co-exposure / vote-loss weights rather than genuine network dependency
- Published significance cannot be reproduced (software/method discrepancy)
