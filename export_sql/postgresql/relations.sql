COPY (
  SELECT rel_kcu.table_schema AS schema,
         rel_kcu.table_name   AS table,
         rel_kcu.column_name  AS column,
         kcu.ordinal_position AS no,
         kcu.table_schema     AS relation_table_schema,
         kcu.table_name       AS relation_table,
         kcu.column_name      AS relation_column,
         kcu.constraint_name
    FROM information_schema.table_constraints tco
         JOIN information_schema.key_column_usage kcu
            ON tco.constraint_schema = kcu.constraint_schema
            AND tco.constraint_name = kcu.constraint_name
         JOIN information_schema.referential_constraints rco
            ON tco.constraint_schema = rco.constraint_schema
            AND tco.constraint_name = rco.constraint_name
         JOIN information_schema.key_column_usage rel_kcu
            ON rco.unique_constraint_schema = rel_kcu.constraint_schema
            AND rco.unique_constraint_name = rel_kcu.constraint_name
            AND kcu.ordinal_position = rel_kcu.ordinal_position
   WHERE tco.constraint_type = 'FOREIGN KEY' AND kcu.table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY kcu.table_schema,
         kcu.table_name,
         kcu.ordinal_position
) TO STDOUT DELIMITER ',' CSV HEADER