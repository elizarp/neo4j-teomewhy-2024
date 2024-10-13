// TOP 10 customers by customer.points 
MATCH (customer:Customer)
RETURN customer.id as customerId, customer.points as points
ORDER BY points DESC
LIMIT 10

// TOP 10 customers by transactions
MATCH (customer:Customer)-[:EXECUTES]->(transaction:Transaction)
WITH customer, count(transaction) as qty
RETURN customer.id as customerId, qty 
ORDER BY qty DESC
LIMIT 10

// customer.points <> sum(transaction.transactionPoints)
MATCH (customer:Customer)-[:EXECUTES]->(transaction:Transaction)
WITH customer, sum(transaction.transactionPoints) as transactionPoints
WITH customer.id as customerId, customer.points as points, transactionPoints
WHERE points <> transactionPoints
RETURN customerId, points, transactionPoints
ORDER BY points DESC


// Duas transacoes para produtos diferentes com menos de 1 segundo entre elas
MATCH (product1:Product)<-[:HAS_PRODUCT]-(transaction:Transaction)-[n:NEXT]->(nextTransaction:Transaction)-[:HAS_PRODUCT]->(product2:Product), 
      (customer:Customer)-[:EXECUTES]->(transaction)
WHERE elementId(product1) <> elementId(product2) AND n.diffMs < 1000
RETURN * LIMIT 1;


// 5 transacoes que foram feitas em menos de 2 segundos
MATCH path=(firstTransaction:Transaction)-[n:NEXT*5..10]->(lastTransaction:Transaction), (customer:Customer)-[:EXECUTES]->(firstTransaction)
WITH customer, path, reduce(totalMs = 0, r IN relationships(path) | totalMs + r.diffMs) as totalMs 
WHERE totalMs > 0 AND totalMs < 2000
RETURN path, customer, totalMs LIMIT 1;

// Produtos mais Populares em Transações Consecutivas:
MATCH (t1:Transaction)-[:NEXT]->(t2:Transaction),
      (t1)-[:HAS_PRODUCT]->(p:Product),
      (t2)-[:HAS_PRODUCT]->(p)
RETURN p.id, count(*) AS popularity
ORDER BY popularity DESC
LIMIT 10



// Limpar base
// MATCH (n) DETACH DELETE n

// Remover constraints
// CALL apoc.schema.assert({}, {})