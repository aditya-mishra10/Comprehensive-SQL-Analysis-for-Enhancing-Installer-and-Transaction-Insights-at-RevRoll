# Comprehensive-SQL-Analysis-for-Enhancing-Installer-and-Transaction-Insights-at-RevRoll
This SQL project aims to provide in-depth insights into installer performance and customer transaction behavior. It reflects the focus on both the competitive participation of installers and the spending patterns of customers, along with detailed analysis of installed orders and installer activity patterns.
### Project Description

This project focuses on leveraging SQL to gain comprehensive insights into RevRoll’s installer performance and customer transaction behaviors. Through a series of targeted queries, we will address key business questions that help improve operational efficiency and strategic decision-making.

**1. Identifying Installers in Competitions**
To recognize and potentially reward installers who actively participate in company events, we will identify those who have participated in at least one installer competition. This query will return the names of these installers, highlighting their engagement and competitive spirit.

**2. Analyzing Customer Transaction Patterns**
We aim to understand customer spending behavior by identifying the third transaction of each customer where the spending is higher than the preceding two transactions, focusing only on transactions that include an installation. This analysis will provide insights into customer purchasing patterns and help identify potential opportunities for targeted marketing and sales strategies.

**3. Reporting the Most Expensive Parts in Orders**
To optimize inventory and pricing strategies, we will write a query to report the most expensive part in each order that includes an installation. In cases of a tie, all parts with the maximum price will be reported. This analysis will help RevRoll understand which high-value parts are frequently installed, aiding in better inventory management and pricing decisions.

**4. Identifying Installers with Consecutive Installations**
We will find installers who have completed installations for at least four consecutive days, including their installer ID, start date, and end date of the consecutive installation period. This query will help RevRoll monitor installer productivity and identify highly active installers, which can be useful for workforce planning and recognition programs.

By addressing these four questions, the project will deliver a detailed SQL analysis that enhances RevRoll’s understanding of both installer activities and customer transactions. The insights gained will support strategic decisions, improve customer engagement, and optimize operations, ultimately contributing to the company's growth and success.

**Data Dictionary**

**Table 1-- customers: customer details**

customer_id: unique customer ID (key, integer)

preferred_name: name preferred by the customer (varchar(50))

**Table 2-- installers: information about installers**

installer_id: unique installer ID (key, integer)

name: name of the installer (varchar(50))

**Table 3-- installs: records of installations**

install_id: unique install ID (key, integer)

order_id: ID of the order (integer)

installer_id: ID of the installer (integer)

install_date: date of installation (date)

**Table 4-- orders: details of customer orders**

order_id: unique order ID (key, integer)

customer_id: ID of the customer (integer)

part_id: ID of the part ordered (integer)

quantity: number of parts ordered (integer)

**Table 5-- parts: information about parts**

part_id: unique part ID (key, integer)

name: name of the part (varchar(50))

price: price of the part (numeric)

**Table 6-- install_derby: records of installer competitions**

derby_id: unique derby ID (key, integer)

installer_one_id: ID of the first installer (integer)

installer_two_id: ID of the second installer (integer)

installer_one_time: time taken by the first installer (integer)

installer_two_time: time taken by the second installer (integer)
