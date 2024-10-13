CALL gds.graph.project(
    'transaction_products_by_customer',
    ['Customer','Product'],
    ['HAS_TRANSACTION_PRODUCT'],
    {
        relationshipProperties:['totalQuantity']
    }
);


CALL gds.nodeSimilarity.mutate(
    'transaction_products_by_customer',
    {
        topK:15,
        mutateProperty:'similarityScore',
        mutateRelationshipType:'HAS_SIMILAR_BEHAVIOR',
        relationshipWeightProperty:'totalQuantity',
        similarityCutoff: 0.8
    }
) YIELD nodesCompared, relationshipsWritten;

CALL gds.graph.writeRelationship(
    'transaction_products_by_customer', 
    'HAS_SIMILAR_BEHAVIOR', 
    'similarityScore');


CALL gds.graph.drop('transaction_products_by_customer');


