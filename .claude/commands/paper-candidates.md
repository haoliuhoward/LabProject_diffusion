# CLEAN Replication Candidate Papers

> Papers using spatial lag / SAR models in political science (2000–present).
> Suitable for CLEAN replication. Updated iteratively — add new papers here as found.
> **Last updated:** 2026-03-03

---

## Already Replicated (exclude from search)

| Paper | Status |
|-------|--------|
| Hinkle (2014) AJPS — Federal Courts and State Policy Diffusion | In progress |
| Genovese, Kern & Martin (2017) ISQ — Policy Alteration | Completed |
| Wimpy, Whitten & Williams (2021) JoP — X Marks the Spot (SAR vs. SLX) | In progress |
| Nyhan & Montgomery (2015) JoP — Connecting the Candidates | Full CLEAN QMD done |
| Olar (2019) JPR — Diffusion of Repression in Authoritarian Regimes | Tutorial stage |

---

## Strong Candidates

- **[[W]hat Lies Beneath: Using Latent Networks to Improve Spatial Predictions](https://doi.org/10.1093/isq/sqac012)**
  — Dorff, Gallop & Minhas (2022, *International Studies Quarterly*)
  Network: country-to-country conflict spillover | W: geographic, shared groups, institutional ties (multiple competing matrices)
  Homophily: conflict spreads via observed ties AND unobserved shared conditions (ethnic composition, state capacity)
  Data: Uppsala Conflict Data Project (UCDP) — publicly accessible
  Note: paper itself proposes unsupervised latent network learning — CLEAN's SBM approach aligns perfectly; high theoretical fit

---

## Moderate Candidates

- **[Historical Border Changes, State Building, and Contemporary Trust in Europe](https://doi.org/10.1017/S0003055421001040)**
  — Abramson, Carter & Ying (2022, *American Political Science Review*)
  Network: geographic locations (NUTS3-level, European regions) | W: distance-based
  Homophily: border regions and neighboring areas both experienced similar border shocks AND have correlated trust
  Data: European Social Survey (ESS) + historical border data — excellent accessibility
  Note: individual-level outcome nested in geographic units; requires aggregation step before CLEAN

- **[Show Me the Money: Interjurisdictional Political Competition and Fiscal Extraction in China](TBD)**
  — Shaw et al. (year TBD)
  Network: Chinese provincial/municipal network | W: administrative hierarchy / geographic contiguity
  Homophily: provinces in same region face similar extraction pressure AND share development levels
  Data: Chinese government statistics — partial accessibility; verify before committing

---

## To Investigate (not yet screened)

> Papers flagged as likely candidates but not yet fully verified for data accessibility and model fit.
> Add new entries here during search sweeps, then promote to Strong/Moderate after screening.

- Beck, Gleditsch & Beardsley (2006) JoP — "Space is More than Geography" (foundational; check if substantive application included)
- Franzese & Hays (2007) Political Analysis — "Spatial Econometric Models of Cross-Sectional Interdependence" (methods paper; check for application)
- [Add more here from search sweeps]

---

## Search Log

| Date | Source searched | Terms used | Papers found |
|------|----------------|------------|--------------|
| 2026-03-03 | Project exploration (existing folders + candidate folder) | N/A | 4 candidates identified |
| [next sweep] | Google Scholar, Political Analysis, AJPS | "spatial lag" "SAR model" "policy diffusion" | TBD |
