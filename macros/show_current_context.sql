-- macros/show_current_context.sql
{% macro show_current_context() %}
{% set results = run_query(
  "select current_account() as account,
          current_region() as region,
          current_database() as database,
          current_schema() as schema,
          current_role() as role"
) %}
{{ log(results.columns, info=True) }}
{{ log(results.rows, info=True) }}
{% endmacro %}
