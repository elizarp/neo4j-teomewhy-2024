MATCH (c:Customer)-[:EXECUTES]->(t:Transaction)-[hp:HAS_PRODUCT]->(p:Product)
WITH c, count(distinct t) as transactions, sum(hp.quantity) as totalQuantity, p   
MERGE (c)-[r:HAS_TRANSACTION_PRODUCT]->(p)
SET r.transactions = transactions,
    r.totalQuantity = totalQuantity
