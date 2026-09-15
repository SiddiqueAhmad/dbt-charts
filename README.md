# dbt Charts Lab

A small, focused playground for exploring **dbt Charts** as dashboards-as-code.

This repo is intentionally about the charting layer itself:

- declarative dashboard YAML
- SQL-backed charts
- dbt `ref()` integration
- interactive filters
- multiple chart types and layouts
- local self-hosting with `dct serve`
- CI validation with dbt + DuckDB + dbt Charts
- HTML rendering as a build artifact

The sample dataset is deliberately simple so the charts remain the main subject.

## What is included

`charts/chart_gallery.yml` demonstrates a compact gallery of common dashboard patterns:

- KPI cards
- line chart
- area chart
- bar chart
- donut chart
- scatter plot
- heatmap
- detail table
- interactive filtering

The data path is:

```text
CSV seed
  -> dbt
  -> DuckDB
  -> dbt manifest
  -> dbt Charts
  -> live dashboard / HTML render
```

## Versions

The demo is pinned to:

- dbt Charts `0.7.1`
- dbt Core `1.11.8`
- dbt DuckDB `1.10.0`
- Python `3.12`

## Run locally

```bash
python -m venv .venv
source .venv/bin/activate

python -m pip install --upgrade pip
python -m pip install \
  'dbt-charts==0.7.1' \
  'dbt-core==1.11.8' \
  'dbt-duckdb==1.10.0'

dbt build --profiles-dir .
dbt parse --profiles-dir .

dct validate charts --project-dir .
dct validate charts --warehouse --project-dir .
```

## Serve the dashboard

```bash
dct serve --host 0.0.0.0 --port 19415 --project-dir .
```

Then open the local server and browse `charts/chart_gallery.yml`.

## Render HTML

```bash
mkdir -p renders

dct render charts/chart_gallery.yml \
  --format html \
  --output renders/chart_gallery.html \
  --project-dir .
```

## CI

GitHub Actions verifies the full path on every change:

1. build the dbt project
2. run dbt tests
3. generate the dbt manifest
4. validate dbt Charts structure and references
5. validate compiled queries against DuckDB
6. render the dashboard to HTML
7. deliberately break a dbt `ref()` and confirm CI catches it
8. upload the rendered dashboard as an artifact

## Why this repo exists

I wanted a minimal way to answer a simple question:

> Can dashboards live next to dbt models as reviewable, testable code without introducing a separate BI configuration layer for every experiment?

This repo is the working notebook for that question.

---

**dbt Charts is currently beta / pre-1.0.** The YAML surface may still evolve, so this repo pins the version used by CI.
