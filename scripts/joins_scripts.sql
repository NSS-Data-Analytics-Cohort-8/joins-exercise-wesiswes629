-- ** Movie Database project. See the file movies_erd for table\column info. **

-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT s.film_title AS name, 
	s.release_year AS release_year, 
	r.worldwide_gross AS lowest_grossing
FROM specs AS s 
INNER JOIN revenue AS r
	USING (movie_id)
	ORDER BY lowest_grossing
	LIMIT 1;

-- Answer:  Semi-Tough, released 1977, grossed $37,187,139

-- 2. What year has the highest average imdb rating?

SELECT s.release_year AS year, 
	AVG(r.imdb_rating) AS avg_rating
FROM specs AS s
INNER JOIN rating AS r
	USING (movie_id) 
GROUP BY year
ORDER BY avg_rating DESC
LIMIT 1;
	
-- 3. What is the highest grossing G-rated movie? Which company distributed it?

SELECT s.film_title AS name,
	d.company_name AS distributor
FROM specs AS s
INNER JOIN revenue AS r
	USING (movie_id)
INNER JOIN distributors AS d
	ON s.domestic_distributor_id = d.distributor_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC
LIMIT 1;

-- Answer: Toy Story 4, released by Walt Disney

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT d.company_name AS distributor,
	COUNT(s.film_title) AS movies
FROM distributors AS d
LEFT JOIN specs AS s
	ON d.distributor_id = s.domestic_distributor_id
GROUP BY distributor
ORDER BY distributor;	

-- 5. Write a query that returns the five distributors with the highest average movie budget.

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
