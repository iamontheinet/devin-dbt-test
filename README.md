# devin-dbt-test

dbt project (`devin_dbt_test`) deployed as a dbt Project on Snowflake in `DASH_DB.DEVIN_DEV`.

## Support analytics pipeline

```
DASH_SCHEMA.SUPPORT_TICKETS -> stg_support_tickets ┐
                                                   ├-> int_interactions_unioned -> int_interactions_enriched -> fct_interactions -> dim_customers
DASH_SCHEMA.EMAILS          -> stg_emails ---------┘                               (AI_SENTIMENT, AI_CLASSIFY;     └-> agg_sentiment_by_category
                                                                                    incremental)
```

- **staging** (views): light cleanup of the raw sources.
- **intermediate**: tickets and emails stacked into one interaction grain (the sources share no keys, so they are separate `channel`s), then enriched with Cortex `AI_SENTIMENT` / `AI_CLASSIFY`. Enrichment is incremental so AI functions only run on new rows. Categories live in `macros/interaction_categories.sql`.
- **marts** (tables): `fct_interactions`, `dim_customers`, `agg_sentiment_by_category`, `dbt_tickets_by_service`.

## Deploy / run

```sql
ALTER GIT REPOSITORY DASH_DB.DEVIN_DEV.DEVIN_DBT_REPO FETCH;
CREATE OR REPLACE DBT PROJECT DASH_DB.DEVIN_DEV.DEVIN_DBT
  FROM '@DASH_DB.DEVIN_DEV.DEVIN_DBT_REPO/branches/main';
EXECUTE DBT PROJECT DASH_DB.DEVIN_DEV.DEVIN_DBT ARGS = 'build';
```
