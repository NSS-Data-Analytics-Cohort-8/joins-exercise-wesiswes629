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


SELECT d.company_name AS distributor,
	s.domestic_distributor_id AS dist_id,
	ROUND(AVG(r.film_budget), 2) AS avg_budget
FROM specs AS s
INNER JOIN revenue AS r
USING (movie_id)
INNER JOIN distributors AS d
	ON s.domestic_distributor_id = d.distributor_id
GROUP BY distributor,dist_id
ORDER BY avg_budget DESC
LIMIT 5;

-- Answer: Ranked in Order--Walt Disney, Sony Pictures, Lionsgate, DreamWorks, and Warner Bros.

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT d.company_name AS distributors,
	d.headquarters AS headquarters, 
	s.film_title AS title,
	r.imdb_rating
FROM specs AS s
INNER JOIN rating AS r
	USING (movie_id)
INNER JOIN distributors AS d
	ON d.distributor_id = s.domestic_distributor_id
	WHERE headquarters NOT LIKE '%CA'
ORDER BY r.imdb_rating DESC;

-- Answer:  Dirting Dancing, distributed by Vestron Pictures out of Chicago, Illinois.

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT t1.rating, t1.under_2, t2.over_2
	FROM (SELECT mpaa_rating AS rating, 
	COUNT(length_in_min) AS under_2
FROM specs
WHERE length_in_min <120
GROUP BY rating) AS t1,
(SELECT mpaa_rating AS rating, 
	COUNT(length_in_min) AS over_2
FROM specs
WHERE length_in_min > 120
GROUP BY rating) AS t2
WHERE t1.rating = t2.rating;

-- Answer: Movies over 120 minutes tended to have a higher rating than movies under 120 minutes.  Average rating for 2+ hours was PG-13, for -2 hours it was PG.