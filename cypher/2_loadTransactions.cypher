LOAD CSV WITH HEADERS FROM 'file:///transactions.csv' as row FIELDTERMINATOR ';'

WITH row WHERE row.dtTransaction IS NOT NULL
MERGE (customer:Customer {id: row.idCustomer})

MERGE (transaction:Transaction {id: row.idTransaction})
SET transaction.transactionDate =  datetime({ epochmillis: apoc.date.parse(row.dtTransaction) }),
    transaction.transactionPoints = toInteger(row.pointsTransaction)

MERGE (customer)-[:EXECUTES]->(transaction)