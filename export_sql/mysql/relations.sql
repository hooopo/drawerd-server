SELECT 'public' AS `schema`,
       kcu.referenced_table_name AS `table`,
       kcu.referenced_column_name AS `column`,
       kcu.ordinal_position AS no,
       'public' AS relation_table_schema,
       kcu.table_name AS relation_table,
       kcu.column_name AS relation_column
  from information_schema.key_column_usage AS kcu
 where referenced_column_name is not null AND CONSTRAINT_SCHEMA = 'drawerd'