-- Which city corresponds to the best customers?

SELECT c.City--, SUM(i.total) as Total 
FROM customers c INNER JOIN 
	 invoices i ON c.CustomerId = i.CustomerId
GROUP BY c.City
ORDER BY SUM(i.total) DESC
LIMIT 1;

-- The highest number of invoices belongs to which country?

SELECT c.City
FROM customers c INNER JOIN 
	 invoices i ON c.CustomerId = i.CustomerId
GROUP BY c.City
ORDER BY COUNT(i.InvoiceId) DESC
LIMIT 1;

--Name the best customer (customer who spent the most money).

SELECT c.FirstName, c.LastName--, SUM(i.total) as Total 
FROM customers c INNER JOIN 
	 invoices i ON c.CustomerId = i.CustomerId
GROUP BY c.FirstName, c.LastName
ORDER BY SUM(i.total) DESC
LIMIT 1;

--Suppose you want to host a rock concert in a city and want to know which location should host it. 
--Query the dataset to find the city with the most rock-music listeners to answer this question.


SELECT c.City
FROM customers c INNER JOIN
	 invoices i ON c.CustomerId = i.CustomerId INNER JOIN 
	 invoice_items it ON i.InvoiceId = it. InvoiceId INNER JOIN 
	 tracks t ON it.TrackId = t.TrackId INNER JOIN
	 genres g ON t.GenreId = g.GenreId
WHERE g.name = 'Rock'
GROUP BY c.City
ORDER BY COUNT(DISTINCT c.CustomerId) DESC
LIMIT 1


-- If you want to know which artists the store should invite, find out who is the highest-paid and most-listened-to.
SELECT ar.name, SUM(i.total), SUM(Milliseconds)
FROM invoices i INNER JOIN 
	 invoice_items it ON i.InvoiceId = it.InvoiceId INNER JOIN
	 tracks t ON it.TrackId = t.TrackId INNER JOIN 
	 albums a ON t.AlbumId = a.AlbumId INNER JOIN
	 artists ar ON a.ArtistId = ar.ArtistId INNER JOIN 
	 genres g ON t.GenreId = g.GenreId 
WHERE g.name = 'Rock'
GROUP BY ar.name 
ORDER BY SUM(i.total) DESC, SUM(Milliseconds) DESC
LIMIT 5