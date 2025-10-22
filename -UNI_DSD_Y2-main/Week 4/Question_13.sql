--Q13. You are given the following query and the associated query tree. Optimise the query tree by applying predicate pushdown (move filters closer to the base tables).
            π o_id, customer_name, total
                            │
        γ o_id, customer_name; SUM(oi.quantity*oi.unit_price)
                            │
            ⋈ o.customer_id = c.customer_id
                    /                          \
        oi.product_id = p.product_id        Customers
                        /       \
                    ⋈ o_id = oi.o_id
                    /                \
σ o.order_date >= DATE '2024-01-01'   OrderItems
                                            │
                                           Orders
                                              \
                                                σ p.category='Accessories'
                                                │
                                            Products

