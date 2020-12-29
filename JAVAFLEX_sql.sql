SELECT * from movie;
SELECT ROWNUM,a.*
FROM (SELECT movie_name, movie_viewcnt
        FROM movie
        ORDER BY movie_viewcnt DESC) a 
where ROWNUM <=10;

SELECT ROWNUM,a.*
FROM (SELECT movie_name, movie_score
        FROM movie
        ORDER BY movie_score DESC) a 
where ROWNUM <=10;

SELECT movie_name, movie_score, MOVIE_OPENDATE
        FROM movie
        WHERE movie_opendate between sysdate AND SYSDATE +10
        ORDER BY movie_score DESC;
        
SELECT movie_name, movie_score, MOVIE_OPENDATE
        FROM movie
        WHERE movie_opendate between sysdate+10 AND SYSDATE+30
        ORDER BY movie_score DESC;
    

SELECT * FROM alias
WHERE mem_id = 'flex';







