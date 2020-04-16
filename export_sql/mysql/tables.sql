select 'public' as table_schema,
       col.table_name,
       col.column_name,
       col.ordinal_position,
       col.data_type as column_type,
       case when (group_concat(constraint_type separator ', '))
                  like '%PRIMARY KEY%'
            then 't' else 'f' end as primary_key,
       case when col.is_nullable = 'YES' then 't' else 'f' end as is_nullable,
       tab.table_comment,
       col.column_comment
from information_schema.columns col
join information_schema.tables tab
     on col.table_schema = tab.table_schema
     and col.table_name = tab.table_name
     and tab.table_type = 'BASE TABLE'
left join information_schema.key_column_usage kcu
     on col.table_schema = kcu.table_schema
     and col.table_name = kcu.table_name
     and col.column_name = kcu.column_name
left join information_schema.table_constraints tco
     on kcu.constraint_schema = tco.constraint_schema
     and kcu.constraint_name = tco.constraint_name
     and kcu.table_name = tco.table_name
where col.table_schema = 'petri_flow_dev' and col.table_schema not in('information_schema', 'sys',
                              'performance_schema', 'mysql')
group by 1,2,3,4,5,7,8,9
order by col.table_schema,
         col.table_name,
         col.ordinal_position