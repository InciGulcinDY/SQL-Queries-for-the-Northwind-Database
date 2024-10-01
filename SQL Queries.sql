--1. Create a report that shows the CategoryName and Description from the categories table sorted by CategoryName.
SELECT category_name, description FROM categories ORDER BY category_name

--2. Create a report that show the ContactName, CompanyName, ContactTitle and Phone number from the customers table sorted by Phone.
SELECT contact_name, company_name, contact_title, phone FROM customers ORDER BY phone

--3. Create a report that shows the capitalized FirstName and capitalized LastName renamed as First Name and Last Name respectively and 
--HireDate from the employees table sorted from the newest to the oldest employee.
SELECT UPPER(first_name) AS "First Name", UPPER(last_name) AS "Last Name", hire_date
FROM employees ORDER BY hire_date DESC;

--4. Create a report that shows the top 10 OrderID, OrderDate, ShippedDate, CustomerID, Freight from the orders table sorted by Freight 
--in descending order.
SELECT order_id, order_date, shipped_date, customer_id, freight FROM orders ORDER BY freight DESC LIMIT 10

--5. Create a report that shows the CustomerID in lowercase letter and renamed as ID from the customers table.
SELECT LOWER(customer_id) AS "ID" FROM customers

--6. Create a report that shows the CompanyName, Fax, Phone, Country, HomePage from the suppliers table sorted by the Country in descending 
--order then by CompanyName in ascending order.
SELECT company_name, fax, phone, country, homepage FROM suppliers ORDER BY country DESC ,company_name ASC 

--7. Create a report that shows CompanyName, ContactName of all customers from ‘Buenos Aires’ only.
SELECT company_name, contact_name FROM customers 
WHERE city='Buenos Aires'

SELECT company_name, contact_name FROM customers 
WHERE city LIKE 'Buenos Aires'

--8. Create a report showing ProductName, UnitPrice, QuantityPerUnit of products that are out of stock.
SELECT product_name, unit_price, quantity_per_unit FROM products
WHERE units_in_stock=0

--9. Create a report showing all ContactName, Address, City of all customers not from Germany, Mexico, Spain.
SELECT contact_name, address, city FROM customers
WHERE NOT country IN ('Germany', 'Mexico', 'Spain')

SELECT contact_name, address, city FROM customers
WHERE country NOT IN ('Germany', 'Mexico', 'Spain')

--10. Create a report showing OrderDate, ShippedDate, CustomerID, Freight of all orders placed on 21 May 1997.
SELECT order_date, shipped_date, customer_id, freight FROM orders 
WHERE order_date='1997-05-21'

--11. Create a report showing FirstName, LastName, and Country from the employees not from the Unites States.
SELECT first_name, last_name, country FROM employees
WHERE NOT country='USA'

--12. Create a report that shows the EmployeeID, OrderID, CustomerID, RequiredDate, ShippedDate from all orders shipped later than the required date.
SELECT employee_id, order_id, required_date, shipped_date FROM orders
WHERE required_date < shipped_date

--13. Create a report that shows the City, CompanyName, ContactName of Customers from cities starting with A or B.
SELECT city, company_name, contact_name FROM customers
WHERE city LIKE 'A%' OR city LIKE 'B%'

--14. Create a report showing all the even numbers of OrderID from the orders table.
SELECT order_id FROM orders
WHERE order_id % 2 = 0

--15. Create a report that shows all the orders where the freight cost more than $500.
SELECT * FROM orders
WHERE freight > 500

--16.Create a report that shows the ProductName, UnitInStock, UnitsOnOrder, ReorderLevel of all products that are up for reorder.
SELECT product_name, units_in_stock, units_on_order, reorder_level FROM products
WHERE units_in_stock != 0

--17. Create a report that shows the CompanyName, ContactName of all customer that have fax number.
SELECT company_name, contact_name FROM customers
WHERE fax IS NOT NULL

--18. Create a report that shows the FirstName, LastName of all employees that do not report to anybody.
SELECT first_name, last_name FROM employees
WHERE reports_to IS NULL

--19. Create a report showing all the odd numbers of OrderID from the orders table.
SELECT order_id FROM orders
WHERE order_id % 2 != 0

--20. Create a report that shows the City, CompanyName, ContactName of customers from cities that has letter L in the name sorted by ContactName.
SELECT city, company_name, contact_name FROM customers
WHERE city LIKE '%L%'
ORDER BY contact_name

--21. Create a report that shows the city, CompanyName, ContactName, Fax of all customers that do not have Fax number and sorted by ContactName.
SELECT city, company_name, contact_name, fax FROM customers
WHERE fax  IS NULL
ORDER BY contact_name


--22. List the total sales (quantity * unit price) for each product
SELECT product_id, SUM(quantity*unit_price) AS total_sales FROM order_details
GROUP BY product_id
ORDER BY total_sales DESC

--23. Find the number of orders placed by each customer
SELECT customer_id, COUNT(*) AS total_orders FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;

SELECT customer_id, COUNT(order_id) AS total_orders FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;

--24. Show all orders that have not been shipped yet
SELECT * FROM orders
WHERE shipped_date IS NULL

--25. List the products that have never been ordered
SELECT product_id, product_name
FROM products
WHERE product_id NOT IN (SELECT product_id FROM order_details);

--26. Find the top 5 customers who have placed the most orders
SELECT customer_id, COUNT(order_id) AS "Total Orders" FROM orders
GROUP BY customer_id
ORDER BY "Total Orders" DESC
LIMIT 5

--27. Show the total freight charges for each customer
SELECT customer_id, SUM(freight) AS "Total Freight Charges" FROM orders
GROUP BY customer_id

--28. Find the employee who processed the most orders
SELECT employee_id, COUNT(order_id) AS "OrderCount" FROM orders
GROUP BY employee_id
ORDER BY "OrderCount" DESC
LIMIT 1

--29. List all suppliers number from the same country
SELECT country, COUNT(supplier_id) AS supplier_count
FROM suppliers
GROUP BY country
HAVING COUNT(supplier_id) > 1;

--30. Find the most ordered product by total quantity
SELECT product_id, SUM(quantity) AS "TotalOrderQuantity" FROM order_details
GROUP BY product_id
ORDER BY "TotalOrderQuantity" DESC
LIMIT 1

--31. Get the average freight cost for orders shipped to each country
SELECT ship_country, ROUND(AVG(freight)) AS "Average Freight Cost" FROM orders
GROUP BY ship_country

--32. List all products and the number of orders they appear in
SELECT product_id, COUNT(order_id) AS "NumberOfOrders" FROM order_details
GROUP BY product_id
ORDER BY "NumberOfOrders" DESC

--33. Find customers who have placed orders over $500 in total
SELECT customer_id, SUM(quantity * unit_price) AS total_order_value FROM order_details
JOIN orders ON order_details.order_id = orders.order_id
GROUP BY customer_id
HAVING SUM(quantity * unit_price) > 500

--34. List employees and the number of orders they handled
SELECT employee_id, COUNT(order_id) AS order_count FROM orders
GROUP BY employee_id
ORDER BY order_count DESC

--35. Find the products that are priced above average price
SELECT product_name, unit_price FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products)

--36. Get the most expensive product from each category
SELECT category_id, product_name, unit_price FROM products
WHERE unit_price = (SELECT MAX(unit_price) FROM products p WHERE p.category_id = products.category_id)
ORDER BY category_id

--37. List all orders along with the customer name
SELECT orders.order_id, orders.order_date, customers.contact_name FROM orders
JOIN customers ON orders.customer_id = customers.customer_id

--38. Find all employees who have processed orders, and include the total number of orders they handled
SELECT employees.employee_id, employees.first_name, employees.last_name, COUNT(orders.order_id) AS total_orders FROM employees
JOIN orders ON employees.employee_id = orders.employee_id
GROUP BY employees.employee_id, employees.first_name, employees.last_name

--39. List all orders along with the product names and quantities ordered
SELECT orders.order_id, products.product_name, order_details.quantity FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id;

--40. Find the names of employees and the customers they dealt with in their orders
SELECT employees.first_name AS "Employee Firstname", employees.last_name AS "Employee Lastname", customers.contact_name AS customer_name FROM orders
JOIN employees ON orders.employee_id = employees.employee_id
JOIN customers ON orders.customer_id = customers.customer_id

--41. List all orders along with the shipping company that delivered them
SELECT orders.order_id, orders.order_date, shippers.company_name AS shipper FROM orders
JOIN shippers ON orders.ship_via = shippers.shipper_id;

--42. Get the total quantity ordered for each product, including the product name and category
SELECT products.product_name, categories.category_name, SUM(order_details.quantity) AS "Total Quantity" FROM order_details 
JOIN products ON products.product_id = order_details.product_id
JOIN categories ON categories.category_id = products.category_id
GROUP BY products.product_name, categories.category_name

--43. List all customers and the total freight cost for their orders
SELECT customers.company_name, SUM(orders.freight) AS total_freight FROM orders
JOIN customers ON customers.customer_id = orders.customer_id
GROUP BY customers.company_name

--44. Find the employees who have worked on orders containing a specific product (e.g., 'Chai')
SELECT employees.first_name, employees.last_name, products.product_name FROM orders
JOIN employees ON orders.employee_id = employees.employee_id
JOIN order_details ON order_details.order_id = orders.order_id
JOIN products ON products.product_id = order_details.product_id
WHERE products.product_name = 'Chai'

--45. List all products that have been ordered, including their supplier's name and the total quantity ordered
SELECT products.product_name, suppliers.company_name, SUM(order_details.quantity) AS total_quantity FROM products
JOIN suppliers ON products.supplier_id = suppliers.supplier_id
JOIN order_details ON products.product_id = order_details.product_id
GROUP BY products.product_name, suppliers.company_name

--46. Get the average price of products for each supplier
SELECT suppliers.company_name, AVG(products.unit_price) AS average_price FROM products
JOIN suppliers ON products.supplier_id = suppliers.supplier_id
GROUP BY suppliers.company_name

--47. Find all orders that include products from a specific category (e.g., 'Beverages')
SELECT orders.order_id, products.product_name, categories.category_name FROM orders
JOIN order_details ON orders.order_id = order_details.order_id
JOIN products ON order_details.product_id = products.product_id
JOIN categories ON products.category_id = categories.category_id
WHERE categories.category_name = 'Beverages'

--48.  Find the total sales (quantity * unit price) for each product, including product and supplier information
SELECT products.product_name, suppliers.company_name, SUM(order_details.quantity * order_details.unit_price) AS total_sales FROM order_details
JOIN products ON order_details.product_id = products.product_id
JOIN suppliers ON products.supplier_id = suppliers.supplier_id
GROUP BY products.product_name, suppliers.company_name
ORDER BY total_sales DESC

--49. List all customers, including those who have not placed any orders
SELECT customers.customer_id, customers.contact_name, orders.order_id, orders.order_date FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
ORDER BY customers.customer_id

--50. List all orders, including those that don't have a corresponding customer
SELECT customers.customer_id, customers.contact_name, orders.order_id, orders.order_date FROM customers
RIGHT JOIN orders ON customers.customer_id = orders.customer_id
ORDER BY orders.order_id

