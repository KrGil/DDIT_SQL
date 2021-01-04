SELECT movie_code, watch_date FROM watch WHERE alias_code = 'seil09241' AND watch_date is not null;
SELECT ROWNUM, a.watch_date, b.*, c.type_name 
FROM
    (SELECT movie_code, watch_date FROM watch WHERE alias_code = 'seil09241' ) a, movie b, type c
     WHERE a.movie_code = b.movie_code
      AND movie_opendate is not null
      AND b.type_lgu = c.type_lgu;