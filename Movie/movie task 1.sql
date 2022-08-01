use MOVIES_W3;
go

/* 1. Write a SQL query to find the name and year of the movies. Return movie title, movie release year. */

select mov_title, mov_year from movie;

/* 2. write a SQL query to find when the movie ‘American Beauty’ released. Return movie release year. */

select mov_year from movie where mov_title = 'American Beauty';

/* 3. write a SQL query to find the movie, which was made in the year 1999. Return movie title. */

select mov_title from movie where mov_year =  1999;

/* 4. write a SQL query to find those movies, which was made before 1998. Return movie title. */

select mov_title from movie where mov_year <  1998;

/* 5. write a SQL query to find the name of all reviewers and movies together in a single list. */

select mov_title as list
from movie 
union
select rev_name 
from reviewer where rev_name != '';

/* --- OR ---
	select m.mov_title, re.rev_name 
	from movie m
	join rating ra on ra.mov_id = m.mov_id 
	join reviewer re on ra.rev_id = re.rev_id and re.rev_name != '';
*/

/* 6. write a SQL query to find all reviewers who have rated 7 or more stars to their rating. Return reviewer name. */

select re.rev_name from rating ra 
join reviewer re on ra.rev_id = re.rev_id and ra.rev_stars > 7 and re.rev_name != '';

/* 7. write a SQL query to find the movies without any rating. Return movie title. */

select mov_title from movie
except
select m.mov_title from movie m
join rating ra on ra.mov_id = m.mov_id;

/* 8. write a SQL query to find the movies with ID 905 or 907 or 917. Return movie title. */

select mov_title from movie where mov_id in (905,907,917);


/* 9. write a SQL query to find those movie titles, which include the words 'Boogie Nights'. Sort the result-set in ascending order by movie year. Return movie ID, movie title and movie release year. */

select mov_id, mov_title, mov_year from movie
where mov_title like '%Boogie Nights%' 
order by mov_year;


/* 10. write a SQL query to find those actors whose first name is 'Woody' and the last name is 'Allen'. Return actor ID */

select act_id from actor where act_fname = 'Woody' and act_lname = 'Allen';




 --------------------------------- SUBQUERIES  -------------------------  


/* 1. Find the actors who played a role in the movie 'Annie Hall'. Return all the fields of actor table. */

select * from actor 
where act_id in (
	select act_id from movie_cast 
	where mov_id in(
		select mov_id from movie
		where mov_title = 'Annie Hall'
		)
	);

/* 2. write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. 
Return director first name, last name. */

select dir_fname, dir_lname from director
where dir_id in (
	select dir_id from movie_direction
	where mov_id in (
		select mov_id from movie
		where mov_title = 'Eyes Wide Shut'
		)
	);

/* 3. write a SQL query to find those movies, which released in the country besides UK. Return movie title, movie year, movie time, date of release, releasing country. */

select mov_title, mov_year, mov_time, FORMAT(mov_dt_rel, 'dd-MM-yyyy') release_date, mov_rel_country from movie
where mov_id not in (select mov_id from movie where mov_rel_country = 'UK')

/* 4. write a SQL query to find those movies where reviewer is unknown. Return movie title, year, release date, director first name, last name, actor first name, last name. */

select mov_title, mov_year, FORMAT(mov_dt_rel, 'dd-MM-yyyy') release_date, d.dir_fname director_firstname , d.dir_lname director_lastname, 
a.act_fname actor_firstname, a.act_lname actor_lastname from movie m, director d, actor a
where m.mov_id in (
	select mov_id from rating where rev_id in (
		select rev_id from reviewer where rev_name = '')) 
	and d.dir_id in (select md.dir_id from movie_direction md where md.mov_id = m.mov_id)
	and a.act_id in (select c.act_id from movie_cast c where c.mov_id = m.mov_id);

/* 5. write a SQL query to find those movies directed by the director whose first name is ‘Woody’ and last name is ‘Allen’. Return movie title. */

select mov_title from movie
where mov_id in (
	select mov_id from movie_direction 
		where dir_id in (select dir_id from director where dir_fname = 'Woody' and dir_lname = 'Allen'));

/* 6. write a SQL query to find those years, which produced at least one movie and that, received a rating of more than three stars. Sort the result-set in ascending order by movie year. Return movie year. */

select distinct mov_year from movie
where mov_id in ( select mov_id from rating where rev_stars > 3)
group by mov_year
having COUNT(mov_year) > 0 ;

/* 7. write a SQL query to find those movies, which have no ratings. Return movie title. */

select mov_title from movie 
	where mov_id not in (select mov_id from rating);

/* 8. write a SQL query to find those reviewers who have rated nothing for some movies. Return reviewer name. */

select rev_name from reviewer 
	where rev_id in ( select rev_id from rating where rev_stars is null);

/* 9. write a SQL query to find those movies, which reviewed by a reviewer and got a rating. Sort the result-set in ascending order by reviewer name, movie title, review Stars. Return reviewer name, movie title, review Stars. */

select re.rev_name, m.mov_title, ra.rev_stars from movie m, reviewer re, rating ra 
	where m.mov_id in (	select mov_id from rating where rev_stars is not null )
		and ra.mov_id in (select mov_id from rating where mov_id = m.mov_id) 
		and re.rev_id in (select rev_id from reviewer where rev_id = ra.rev_id and rev_name != '')
	order by re.rev_name, m.mov_title, ra.rev_stars;

/* 10. write a SQL query to find those reviewers who rated more than one movie. Group the result set on reviewer’s name, movie title. Return reviewer’s name, movie title. */

select re.rev_name,mov_title from reviewer re, movie m, rating r
	where re.rev_id in (select rev_id from rating where rev_id = r.rev_id)
		and m.mov_id in (select mov_id from rating where rev_id = re.rev_id ) 
	group by re.rev_name, m.mov_title
	having COUNT(re.rev_name) > 1;


/* 11.  write a SQL query to find those movies, which have received highest number of stars. Group the result set on movie title and sorts the result-set in ascending order by movie title. Return movie title and maximum number of review stars.  */

select m.mov_title, MAX(r.rev_stars) max_rating from movie m, rating r 
	where r.rev_stars is not null 
		and m.mov_id in (select mov_id from movie where mov_id = r.mov_id)
	group by m.mov_title
	order by m.mov_title;

/* 12. write a SQL query to find all reviewers who rated the movie 'American Beauty'. Return reviewer name. */

select rev_name from reviewer
	where rev_id in (
		select rev_id from rating 
			where mov_id in (select mov_id from movie where mov_title = 'American Beauty'));

/* 13. write a SQL query to find the movies, which have reviewed by any reviewer body except by 'Paul Monks'. Return movie title. */

 select mov_title from movie 
 where mov_id in (
	select mov_id from rating 
		where rev_id not in (select rev_id from reviewer where rev_name = 'Paul Monks'));

/* 14. write a SQL query to find the lowest rated movies. Return reviewer name, movie title, and number of stars for those movies. */

select re.rev_name, m.mov_title, ra.rev_stars from movie m, reviewer re, rating ra
where ra.rev_stars in (select MIN(rev_stars) from rating where rev_stars is not null) 
	and re.rev_id in (select rev_id from rating where rev_id = ra.rev_id)
	and m.mov_id in (select mov_id from rating where mov_id = ra.mov_id);


/* 15. write a SQL query to find the movies directed by 'James Cameron'. Return movie title. */

select mov_title from movie
where mov_id in (
	select mov_id from movie_direction 
		where dir_id in (
			select dir_id from director 
				where dir_fname = 'James' and dir_lname = 'Cameron'));

/* 16. Write a query in SQL to find the name of those movies where one or more actors acted in two or more movies. */

select mov_title from movie
where mov_id in (
	select mov_id from movie_cast
		where act_id in(
			select act_id from movie_cast 
				group by act_id having COUNT(act_id) >= 2));


 --------------------------------- JOINS  -------------------------  

 /* 1. write a SQL query to find the name of all reviewers who have rated their ratings with a NULL value. Return reviewer name. */

 select re.rev_name from reviewer re
 join rating ra on re.rev_id = ra.rev_id and ra.rev_stars is null;

 /* 2. write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role. */

 select a.act_fname, a.act_lname, c.role from actor a 
 join movie_cast c on c.act_id = a.act_id
 join movie m on m.mov_id = c.mov_id and m.mov_title = 'Annie Hall';

 /* 3. write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'. Return director first name, last name and movie title.*/

 select d.dir_fname, d.dir_lname, mov_title from director d
 join movie_direction md on md.dir_id = d.dir_id
 join movie m on m.mov_id = md.mov_id and mov_title = 'Eyes Wide Shut';

 /* 4. write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’. Return director first name, last name and movie title. */

  select d.dir_fname, d.dir_lname, mov_title from director d
 join movie_direction md on md.dir_id = d.dir_id
 join movie m on m.mov_id = md.mov_id
 join movie_cast c on c.mov_id = m.mov_id and c.role = 'Sean Maguire';

 /* 5. write a SQL query to find the actors who have not acted in any movie between1990 and 2000 (Begin and end values are included.).  Return actor first name, last name, movie title and release year. */

 select a.act_fname, a.act_lname, m.mov_title, m.mov_year from actor a
 join movie_cast c on c.act_id = a.act_id
 join movie m on c.mov_id = m.mov_id and mov_year not between 1990 and 2000;


 /* 6. write a SQL query to find the directors with number of genres movies. Group the result set on director first name, last name and generic title.  Sort the result-set in ascending order by director first name and last name.
 Return director first name, last name and number of genres movies.*/

 select dir_fname, dir_lname, COUNT(gen_title) no_of_genres from director d
 join movie_direction md on md.dir_id = d.dir_id
 join movie_genres mg on md.mov_id = mg.mov_id
 join genres g on mg.gen_id = g.gen_id
 group by dir_fname, dir_lname, gen_title
 order by dir_fname, dir_lname;

 /* 7. write a SQL query to find the movies with year and genres. Return movie title, movie year and generic title. */

 select mov_title, mov_year, gen_title from movie m
 join movie_genres mg on m.mov_id = mg.mov_id
 join genres g on mg.gen_id = g.gen_id;

 /* 8. write a SQL query to find all the movies with year, genres, and name of the director. */

 select mov_title, mov_year, gen_title, dir_fname director_fname, dir_lname director_lname from movie m
 join movie_direction md on md.mov_id = m.mov_id
 join director d on md.dir_id = d.dir_id
 join movie_genres mg on md.mov_id = mg.mov_id
 join genres g on mg.gen_id = g.gen_id;

 /* 9. write a SQL query to find the movies released before 1st January 1989. Sort the result-set in descending order by date of release. Return movie title, release year, date of release, duration, and first and last name of the director. */
 
 select mov_title, mov_year, FORMAT(mov_dt_rel, 'dd-MM-yyyy') as release_date, mov_time duration, dir_fname director_fname, dir_lname director_lname from movie m
 join movie_direction md on md.mov_id = m.mov_id
 join director d on md.dir_id = d.dir_id
 where mov_dt_rel < '1989-01-01 00:00:00.000'
 order by mov_dt_rel desc;

 /* 10. write a SQL query to compute the average time and count number of movies for each genre. Return genre title, average time and number of movies for each genre. */

 select gen_title, AVG(m.mov_time) average_time, COUNT(gen_title) no_of_movies from genres g
 join movie_genres mg on g.gen_id = mg.gen_id
 join movie m on m.mov_id = mg.mov_id
 group by gen_title;


 /* 11. write a SQL query to find movies with the lowest duration. Return movie title, movie year, director first name, last name, actor first name, last name and role. */

 select m.mov_title, m.mov_year, d.dir_fname director_fname, d.dir_lname director_lname, a.act_fname actor_fname, a.act_lname actor_lname, role from movie m
 join movie_direction md on md.mov_id = m.mov_id
 join director d on md.dir_id = d.dir_id
 join movie_cast c on c.mov_id = md.mov_id
 join actor a on a.act_id = c.act_id
 where mov_time = (select min(mov_time) from movie);

 /* 12. write a SQL query to find those years when a movie received a rating of 3 or 4. Sort the result in increasing order on movie year. Return move year. */

 select distinct mov_year from movie m
 join rating r on r.mov_id = m.mov_id where r.rev_stars between 3 and 4
 order by mov_year;
 

 /* 13. write a SQL query to get the reviewer name, movie title, and stars in an order that reviewer name will come first, then by movie title, and lastly by number of stars.*/

 select re.rev_name, m.mov_title, r.rev_stars from reviewer re
 join rating r on r.rev_id = re.rev_id
 join movie m on r.mov_id = m.mov_id
 where re.rev_name != ''
 order by re.rev_name, m.mov_title, r.rev_stars;

 /* 14. write a SQL query to find those movies that have at least one rating and received highest number of stars. Sort the result-set on movie title. Return movie title and maximum review stars. */

 select m.mov_title, max(rev_stars) highest_rating from movie m 
 join rating r on m.mov_id = r.mov_id and r.rev_stars is not null
 group by m.mov_title;

 /* 15. write a SQL query to find those movies, which have received ratings. Return movie title, director first name, director last name and review stars. */

 select m.mov_title,  dir_fname director_fname, dir_lname director_lname , r.rev_stars  from movie m 
 join rating r on m.mov_id = r.mov_id and r.rev_stars is not null
 join movie_direction md on md.mov_id = m.mov_id
 join director d on d.dir_id = md.dir_id;

 /* 16. Write a query in SQL to find the movie title, actor first and last name, and the role for those movies where one or more actors acted in two or more movies. */

 select mov_title,  act_fname actor_fname, act_lname actor_lname, role from movie m
 join movie_cast c on c.mov_id = m.mov_id 
 and c.act_id in (select act_id from movie_cast group by act_id having COUNT(act_id) > 1)
 join actor a on a.act_id = c.act_id;


   
 --select * from movie;
 --select * from actor;
 --select * from director;
 --select * from genres;
 --select * from movie_cast;
 --select * from movie_direction;
 --select * from movie_genres;
 --select * from rating;
 --select * from reviewer;
