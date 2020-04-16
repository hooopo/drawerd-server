-- psql -d stackrails_dev -q -f export_sql/postgresql/tables.sql > table_csv.csv
COPY (SELECT c.table_schema, 
       c.table_name, 
       c.column_name, 
       c.udt_name as column_type, 
       c.ordinal_position, 
       case when c.is_nullable = 'YES' then 't' else 'f' end as is_nullable, 
       case when kcu.constraint_name is null then 'f' else 't' end as primary_key,
       pg_catalog.col_description(format('%s.%s', c.table_schema, c.table_name)::regclass::oid, c.ordinal_position) as column_comment,
       obj_description(format('%s.%s', c.table_schema, c.table_name)::regclass::oid, 'pg_class') as table_comment 
 FROM  information_schema.columns c 
       LEFT JOIN information_schema.key_column_usage as kcu ON 
         kcu.table_catalog = c.table_catalog and 
         kcu.table_schema = c.table_schema and 
         kcu.table_name = c.table_name and 
         kcu.column_name = c.column_name and 
         kcu.position_in_unique_constraint is NULL
 WHERE c.table_schema not in ('information_schema', 'pg_catalog') 
 ORDER BY 1,2,5
) TO STDOUT DELIMITER ',' CSV HEADER