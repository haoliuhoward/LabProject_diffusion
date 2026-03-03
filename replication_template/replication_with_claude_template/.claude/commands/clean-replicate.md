# CLEAN Replication

You are helping the user apply the CLEAN method (Confounding Latent Embedding Adjustment
for Networks) to a new political science paper. Follow the checklist below in order.

---

## Step 0 — Prerequisites (ask the user before doing anything else)

Tell the user:

> Before I start, I need three things from you:
>
> 1. **Run `/init` first** if you haven't already — this lets me read the repo structure
>    and data files so I understand the paper's setup without you having to explain it.
>
> 2. **Share the original paper PDF** — I need to read the model specification, identify
>    which tables contain ρ (the spatial lag coefficient), understand the adjacency matrix
>    construction, and confirm the outcome variables and covariates.
>
> 3. **Share the CLEAN paper and tutorial PDFs** if they are not already at:
>    - `~/Desktop/Lab/2026_Spring/CLEAN/CLEAN_main.pdf`
>    - `~/Desktop/Lab/2026_Spring/CLEAN/replication_Jack/CLEAN_tutorial_sbm_01222026.pdf`

Do not proceed until the user confirms these are available.

---

## Step 1 — Read and understand the paper

Read the original paper PDF. Extract and confirm with the user:

| Question | Why it matters |
|---|---|
| Which tables contain ρ (the spatial lag)? | Determines scope of the comparison table |
| What is the adjacency matrix? Binary (0/1), count (integers), or continuous? | Determines SBM model type: bernoulli / poisson / gaussian |
| Is the network static (one matrix) or time-varying (one matrix per period)? | Determines `clean_blocks()` vs. `clean_blocks_by_time()` |
| What are the unit ID and time variables in the data? | Required arguments for the CLEAN function |
| What are the key outcome variables? | Needed for the comparison table and Wy computation |

---

## Step 2 — Make CLEAN methodology choices

Based on what you read, decide and explain to the user:

1. **Function**: `clean_blocks()` (static) or `clean_blocks_by_time()` (time-varying)
2. **SBM model**: `"bernoulli"` / `"poisson"` / `"gaussian"`
3. **Year matrices** (if time-varying): how to construct or extract them from available data
4. **Seed**: default to `1`

---

## Step 2.5 — Network visualization preferences

Before writing any code, ask the user the following four questions. Present them together
in a single message and wait for all answers before proceeding.

> I need a few decisions about the network visualization before I write the QMD:
>
> **Q1 — Which time periods to plot?**
> - (a) All time periods — one network plot per period
> - (b) A single period only — which one? (first / most recent / specify)
>
> **Q2 — What label, if any, should appear on each node?**
>
> Units in this network could be candidates, countries, states, legislators, or other
> actors. Choose the label that best identifies them:
> - (a) Short identifier — last name, country/state abbreviation, or short code
> - (b) Full label — full name, full country/state name, or complete identifier
> - (c) No labels — nodes only, colored by block
>
> **Q3 — Label data source** *(only if Q2 = a or b)*
>
> I will inspect the data folder automatically. Please also tell me:
> - Is there a file that maps unit IDs to labels (e.g. a names CSV, a codebook, or a
>   column in the main dataset)? If so, what is its path?
> - If no such file exists, I will attempt to extract labels from the adjacency matrix
>   row/column names or from the bipartite edge list directly.
>
> **Q4 — Filter to a subgroup?**
> - (a) All units in the network
> - (b) A specific subgroup (e.g. democratic candidates, a region, a treaty bloc —
>   specify the filter condition)

Use the answers to set these four variables before writing Step 3:

| Variable | What it controls |
|---|---|
| `net_years` | Which period(s) to plot — e.g. `c("2002","2004","2006")` or `"2002"` |
| `net_labels` | `"short"` / `"full"` / `"none"` |
| `net_labels_source` | File path, column name in main data, `"adjmat_colnames"`, or `"edge_list"` |
| `net_filter` | `"all"` or a logical condition string, e.g. `"democrat == 1"` or `"region == 'Europe'"` |

Ask the user to confirm all four before writing any code.

---

## Step 3 — Create the QMD

Create `[paper-name]-clean.qmd` in the repo root. The QMD must produce **HTML** and
include these six outputs in order.

YAML front matter:
```yaml
format:
  html:
    toc: true
    toc-depth: 3
execute:
  cache: true
  warning: false
  message: false
```

| # | Section | Content |
|---|---|---|
| 1 | Replication check | Reproduce original ρ values; confirm they match published table |
| 2 | Block evolution heatmap | Tile plot: block × time period, fill = candidates per block |
| 3 | Network visualization | One plot per cycle in `net_years`; nodes colored by CLEAN block; labels controlled by `net_labels`; subgroup by `net_filter` |
| 4 | Collinearity: C ~ Wy | `lm(Wy ~ clean_block)` for each outcome; report R² via `modelsummary`; compute Wy using the `compute_Wy` helper (see notes below) |
| 5 | CLEAN models | Re-run original models with `clean_block` added as control using `add_clean` helper (see notes below); suppress `clean_blocks_by_time()` chunk output |
| 6 | Comparison table | ρ, SE, LR statistic — Original vs. CLEAN, side by side |

Standard libraries: `foreign`, `spdep`, `spatialreg`, `CLEAN`, `tidyverse`, `igraph`,
`haven`, `modelsummary`, `knitr`, `kableExtra`, `RColorBrewer`

**Network visualization implementation notes:**
- Build a shared helper function `plot_year_network(yr, label_cex)` called once per cycle
- Label lookup: resolve `net_labels_source` to a vector of labels indexed by unit row
  position; for `"short"` labels apply `gsub("^.* ", "", label)` (last word) for names,
  or use the ISO code / abbreviation column if units are countries or states
- Remove isolated (degree-0) nodes with `delete_vertices(g_yr, which(degree(g_yr) == 0))`;
  do **not** discard smaller connected components — keep all non-isolated nodes
- Auto-scale visual parameters from `vcount(g_plot)` — do **not** hardcode sizes:
  ```r
  n <- vcount(g_plot)
  auto_size  <- dplyr::case_when(n > 200 ~ 4,  n > 80 ~ 7,  n > 30 ~ 12, TRUE ~ 18)
  auto_cex   <- dplyr::case_when(n > 200 ~ 0.45, n > 80 ~ 0.6, n > 30 ~ 0.8, TRUE ~ 1.0)
  auto_ewidth_mult <- dplyr::case_when(n > 200 ~ 1.5, n > 80 ~ 2.0, TRUE ~ 3.0)
  ```
  Use these for `vertex.size`, `vertex.label.cex`, and `edge.width` in the `plot()` call.
  The function signature is `plot_year_network(yr, label_cex = NULL)` where `NULL` triggers
  auto-scaling (use `auto_cex` when `label_cex` is `NULL`)
- Use `mat2listw(..., zero.policy = TRUE)` in `run_sar()`; define `run_sar` once in Step 1
- Table captions: use Unicode `ρ` and plain `Wy` — never raw LaTeX strings inside
  `title =` or `caption =` arguments (they do not render in HTML)

**Collinearity (Section 4) implementation notes:**
- Wy is not directly available from `lagsarlm` output for subsetting; compute it manually
  with this helper:
  ```r
  compute_Wy <- function(adj, sel, data, outcome_col) {
    adj_sub <- adj[sel, sel]; y <- data[[outcome_col]][sel]; y[is.na(y)] <- 0
    rs <- rowSums(adj_sub); W_norm <- sweep(adj_sub, 1, ifelse(rs==0,1,rs), "/")
    W_norm[rs == 0, ] <- 0; as.vector(W_norm %*% y)
  }
  ```
  Call as `compute_Wy(adj_matrix, row_selection, data_frame, "outcome_col_name")`.

**CLEAN models (Section 5) implementation notes:**
- Add `clean_block` to every original formula with this one-liner:
  ```r
  add_clean <- function(f) update(f, . ~ . + clean_block)
  ```
  Pass `add_clean(original_formula)` to the model-fitting function.
- The `clean_blocks_by_time()` (or `clean_blocks()`) chunk produces verbose SBM output.
  Suppress it entirely with chunk options:
  `{r, echo=FALSE, results='hide', message=FALSE, warning=FALSE, fig.show='hide'}`

---

## Step 4 — Update CLAUDE.md

Add a **CLEAN Replication** section to the repo's `CLAUDE.md` containing:

1. **Research question** — one sentence: does ρ survive controlling for latent homophily?
2. **Why this paper suits CLEAN** — the specific homophily confounding mechanism
3. **Interpretation guide** — what each possible ρ outcome (drops/stays/gains) means
4. **Known limitations** — any application-specific caveats (cross-sectional vs. panel,
   adjacency matrix construction choices, etc.)
5. **Outputs table** — the six QMD outputs with "what to look for" notes
6. **Methodology choices table** — function, SBM model, seed, and reasoning
