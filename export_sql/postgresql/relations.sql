COPY (select rel_kcu.table_schema as schema,
       rel_kcu.table_name as table,
       rel_kcu.column_name as column,
       kcu.ordinal_position as no,
       kcu.table_schema as relation_table_schema,
       kcu.table_name as relation_table,
       kcu.column_name as relation_column,
       
       kcu.constraint_name
from information_schema.table_constraints tco
join information_schema.key_column_usage kcu
          on tco.constraint_schema = kcu.constraint_schema
          and tco.constraint_name = kcu.constraint_name
join information_schema.referential_constraints rco
          on tco.constraint_schema = rco.constraint_schema
          and tco.constraint_name = rco.constraint_name
join information_schema.key_column_usage rel_kcu
          on rco.unique_constraint_schema = rel_kcu.constraint_schema
          and rco.unique_constraint_name = rel_kcu.constraint_name
          and kcu.ordinal_position = rel_kcu.ordinal_position
where tco.constraint_type = 'FOREIGN KEY' and kcu.table_schema not in ('information_schema', 'pg_catalog')
order by kcu.table_schema,
         kcu.table_name,
         kcu.ordinal_position
) TO STDOUT DELIMITER ',' CSV HEADER