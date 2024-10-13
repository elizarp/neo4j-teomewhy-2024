CREATE CONSTRAINT customer_id FOR (customer:Customer) REQUIRE (customer.id) IS NODE KEY;

CREATE CONSTRAINT transaction_id FOR (transaction:Transaction) REQUIRE (transaction.id) IS NODE KEY;

CREATE CONSTRAINT product_id FOR (product:Product) REQUIRE (product.id) IS NODE KEY;