LOAD CSV WITH HEADERS FROM 'file:///customers.csv' as row FIELDTERMINATOR ';'
MERGE (customer:Customer {id: row.idCustomer})
SET customer.points = toInteger(row.PointsCustomer),
    customer.email = (row.flEmail="1")