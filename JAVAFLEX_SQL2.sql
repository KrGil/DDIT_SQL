SELECT * 
FROM movie a, type b
WHERE a.TYPE_LGU = b.TYPE_LGU 
    AND movie_code = '12001';

UPDATE movie SET MOVIE_VIEWCNT = movie_viewcnt + 1
WHERE movie_code = 13001;

--영화 좋아요와 스코어 테이블 좋아요 업데이트하기.
UPDATE movie SET movie_score = movie_score+1
WHERE MOVIE_CODE = '13001';
UPDATE movie SET movie_score = 
    CASE 
        WHEN movie_score > 0 THEN movie_score-1
        ELSE movie_score END
WHERE MOVIE_CODE = '12010';


INSERT INTO score values ('GOOD13006flex1', '13006', 'flex1', 0);
UPDATE score SET score_good = score_good+1
WHERE alias_code = 'flex1' 
    AND movie_code = '13001';

-- 찜하기 해야한다요!

SELECT * FROM movie;
SELECT * FROM score;


--paging
SELECT *
FROM
    (SELECT ROWNUM rn, A.*
     FROM 
        (SELECT a.movie_name, a.movie_opendate, b.type_name, a.movie_viewcnt
         FROM movie a, type b
         WHERE a.type_lgu = b.type_lgu
            AND movie_opendate is not null
         ORDER BY movie_viewcnt desc) A )
WHERE rn BETWEEN (7 -1) * 10 + 1 AND (7 * 10);

SELECT a.*
FROM (
        SELECT ROWNUM as rn, movie.* 
        FROM movie
        WHERE movie_opendate is not null) a
WHERE a.rn BETWEEN (:PAGE - 1) * 10 + 1 AND (:PAGE*10);

SELECT *
FROM
    (SELECT ROWNUM rn, A.*
     FROM 
        (SELECT a.movie_name, a.movie_opendate, b.type_name, a.movie_viewcnt
         FROM movie a, type b
         WHERE a.type_lgu = b.type_lgu
            AND movie_opendate is not null
         ORDER BY movie_viewcnt desc) A )
WHERE rn BETWEEN (:page -1) * 10 + 1 AND (:page * 10);

 SELECT *
 FROM
 	(SELECT ROWNUM rn, A.*
     FROM
         (SELECT a.movie_name, a.movie_opendate, b.type_name, a.movie_viewcnt
		  FROM member a, type b
		  WHERE a.type_lgu = b.type_lgu
		  AND movie_opendate is not null
		  ORDER BY movie_viewcnt desc) A )
WHERE rn BETWEEN (1 -1) * 10 + 1 AND (1 * 10);



