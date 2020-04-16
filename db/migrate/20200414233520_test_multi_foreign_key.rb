class TestMultiForeignKey < ActiveRecord::Migration[5.2]
  def up
    execute(<<~EOF)
      CREATE TABLE items_double_primary_keys(item_code integer,item_name character(35),purchase_unit character(10),sale_unit character(10),purchase_price numeric(10,2),sale_price numeric(10,2),PRIMARY KEY (item_code,item_name));
    EOF

    execute("CREATE TABLE items(item_code integer,item_name character(35),purchase_unit character(10),sale_unit character(10),purchase_price numeric(10,2),sale_price numeric(10,2),PRIMARY KEY (item_code,item_name));")
    execute(<<~SQL)
      CREATE TABLE orders(
        ord_no integer PRIMARY KEY,
        ord_date date,item_code integer ,
        item_name character(35),
        item_grade character(1),
        ord_qty numeric,
        ord_amount numeric,
        FOREIGN KEY (item_code,item_name) REFERENCES items(item_code,item_name)
      );
    SQL
  end

  def down
    execute(<<~SQL)
      drop table items_double_primary_keys;
    SQL
    execute("drop table orders")
    execute("drop table items")
  end
end