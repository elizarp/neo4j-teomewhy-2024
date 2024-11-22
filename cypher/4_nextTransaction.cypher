// Use :auto if you are using neo4j desktop
//:auto
MATCH (customer:Customer)
CALL (customer){
    MATCH (customer)-[:EXECUTES]->(transaction:Transaction)
    WITH customer, transaction ORDER BY transaction.transactionDate
    WITH customer, collect(transaction) as listTransactions
    WITH customer, listTransactions, range(0, size(listTransactions)-1) AS ixs
    UNWIND ixs AS ix
    WITH customer, listTransactions, ix WHERE ix > 0
    WITH customer, listTransactions[ix] as transaction, listTransactions[ix-1] as previous
    MERGE (previous)-[n:NEXT]->(transaction)
    SET n.diffMs = datetime(transaction.pedidoDataCriacao).epochMillis - datetime(previous.pedidoDataCriacao).epochMillis
} IN TRANSACTIONS OF 10 ROWS
