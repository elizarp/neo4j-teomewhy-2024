LOAD CSV WITH HEADERS FROM 'file:///transactions_product.csv' as row FIELDTERMINATOR ';'

MERGE (product:Product {id: row.NameProduct})

MERGE (transaction:Transaction {id: row.idTransaction})

MERGE (transaction)-[tp:HAS_PRODUCT]->(product)
SET tp.id_cart = row.idTransactionCart,
    tp.quantity = toInteger(row.QuantityProduct)

