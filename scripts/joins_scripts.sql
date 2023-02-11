-- ** Movie Database project. See the file movies_erd for table\column info. **

-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT s.film_title AS name, 
	s.release_year AS release_year, 
	r.worldwide_gross AS lowest_grossing
FROM specs AS s 
INNER JOIN revenue AS r
	USING (movie_id)
	ORDER BY lowest_grossing;

-- Answer:  Semi-Tough, released 1977, grossed $37,187,139

-- 2. What year has the highest average imdb rating?

-- 3. What is the highest grossing G-rated movie? Which company distributed it?

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

-- 5. Write a query that returns the five distributors with the highest average movie budget.

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
