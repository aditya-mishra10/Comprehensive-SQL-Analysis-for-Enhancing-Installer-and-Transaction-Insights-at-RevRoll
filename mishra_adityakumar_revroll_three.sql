/*
Question #1:

Identify installers who have participated in at least one installer competition by name.

Expected column names: name
*/

-- q1 solution:

SELECT DISTINCT i.name
FROM installers AS i
JOIN install_derby AS id ON i.installer_id = id.installer_one_id OR i.installer_id = id.installer_two_id;


/*
Question #2: 
Write a solution to find the third transaction of every customer, where the spending on the preceding two transactions is lower than the spending on the third transaction. 
Only consider transactions that include an installation, and return the result table by customer_id in ascending order.

Expected column names: customer_id, third_transaction_spend, third_transaction_date
*/

-- q2 solution:

WITH customer_transaction_spend AS (
    SELECT 
        c.customer_id,
        i.install_id AS transaction_id,
        i.install_date AS transaction_date,
        SUM(p.price * o.quantity) AS total_spending,
        ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY i.install_date) AS transaction_rank
    FROM 
        customers AS c
    INNER JOIN 
        installs AS i ON c.customer_id = (SELECT customer_id FROM orders WHERE order_id = i.order_id)
    INNER JOIN 
        orders AS o ON i.order_id = o.order_id
    INNER JOIN 
        parts AS p ON o.part_id = p.part_id
    GROUP BY 
        c.customer_id, i.install_id, i.install_date
)
SELECT 
    t.customer_id,
    t.total_spending AS third_transaction_spend,
    t.transaction_date AS third_transaction_date
FROM 
    customer_transaction_spend AS t
WHERE 
    t.transaction_rank = 3
    AND EXISTS (
        SELECT 1 
        FROM customer_transaction_spend AS rt 
        WHERE rt.customer_id = t.customer_id 
          AND rt.transaction_rank = 2 
          AND rt.total_spending < t.total_spending
    )
    AND EXISTS (
        SELECT 1 
        FROM customer_transaction_spend AS rt 
        WHERE rt.customer_id = t.customer_id 
          AND rt.transaction_rank = 1 
          AND rt.total_spending < t.total_spending
    )
ORDER BY 
    t.customer_id;







/*
Question #3: 
Write a solution to report the **most expensive** part in each order. 
Only include installed orders. In case of a tie, report all parts with the maximum price. 
Order by order_id and limit the output to 5 rows.

Expected column names: `order_id`, `part_id`

*/

-- q3 solution:

SELECT
    o.order_id,
    p.part_id
FROM
    orders AS o
JOIN
    installs AS i ON o.order_id = i.order_id
JOIN
    parts AS p ON o.part_id = p.part_id
WHERE
    o.order_id IN (SELECT order_id FROM installs)
AND
    p.price = (SELECT MAX(price) FROM parts WHERE part_id = p.part_id)
ORDER BY
    o.order_id
LIMIT 5;



/*
Question #4: 
Write a query to find the installers who have completed installations for at least four consecutive days. 
Include the `installer_id`, start date of the consecutive installations period and the end date of the consecutive installations period. 

Return the result table ordered by `installer_id` in ascending order.

E**xpected column names: `installer_id`, `consecutive_start`, `consecutive_end`**
*/

-- q4 solution:

WITH consecutive_installations AS (
    SELECT 
        installer_id,
        install_date,
        install_date - DENSE_RANK() OVER (PARTITION BY installer_id ORDER BY install_date) * INTERVAL '1 day' AS grp
    FROM 
        installs
),
consecutive_groups AS (
    SELECT 
        installer_id,
        MIN(install_date) AS consecutive_start,
        MAX(install_date) AS consecutive_end,
        COUNT(*) AS consecutive_days
    FROM 
        consecutive_installations
    GROUP BY 
        installer_id, grp
    HAVING 
        COUNT(*) >= 4 AND MAX(install_date) - MIN(install_date) = 3
)
SELECT 
    installer_id,
    consecutive_start,
    consecutive_end
FROM 
    consecutive_groups
ORDER BY 
    installer_id ASC;
