# Project Summary

I built this project to practice and demonstrate how I would structure, transform, and serve product data in a real analytics environment. I used the MovieLens 20M dataset as a stand-in for product telemetry and focused on turning raw event data into clear, reliable fact and dimension tables that could be used directly for analysis, reporting, and decision-making.

My emphasis throughout the project was on clarity, correctness, and maintainability, making sure each model has a clear purpose, a well-defined grain, and produces outputs that are easy to trust and easy to use.

## Data & Platform
- Dataset: MovieLens 20M ratings dataset
- Dataset choice: I chose the 20M dataset because it is large enough to feel realistic, well-documented, and widely understood, while still being manageable for an end-to-end project. It allowed me to focus on modeling and analytical quality rather than on operational overhead.
- Source citation:
F. Maxwell Harper and Joseph A. Konstan. 2015. The MovieLens Datasets: History and Context. ACM Transactions on Interactive Intelligent Systems (TiiS), 5(4), Article 19.
- Ingestion: Raw CSV files loaded into AWS S3 and ingested into Snowflake
- Warehouse: Snowflake
- Transformation: dbt (SQL + Jinja)
- Modeling approach: Layered (staging → marts)

### 1. Business Purpose
I approached this as if I were working with real product data: users interacting with content over time. I wanted to be able to answer simple, practical questions like:
- How is engagement changing over time?
- Which movies are gaining or losing interest?
- How active are users on a daily basis?
That framing guided what I modeled and what I left out. I focused on building a small set of tables that could support those questions without adding unnecessary complexity.

### 2. Analytical Design

Rather than building a wide, monolithic model, I organized the data around a few stable ideas:
- Events (ratings),
- Entities (users and movies),
- Time (daily trends).
This led naturally to a core event fact table, supported by small, focused dimensions and a couple of aggregated views for common time-based analysis.

### 3. Data Model Layers
- `Staging (stg_)`
I used staging models to make the raw data usable: renaming columns, casting types, and parsing structured fields like release year and genres so that downstream models could stay simple and readable.
- `Marts (dim_, fct_)`
I kept the mart layer intentionally small. Each table has a single, clear purpose and a defined grain, so it’s easy to reason about metrics and avoid subtle inconsistencies later on.

### 4. Analytics & Use in Practice

I treated the final mart layer as something that would be used directly by others, not just by me. That meant prioritizing:
- Consistent naming and definitions,
- Predictable grains,
- And tables that can be queried without needing to understand the full transformation pipeline.

The result is a set of models that are straightforward to explore, join, and build on in a BI tool, a notebook, or an ad hoc SQL query.
