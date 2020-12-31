SELECT ROWNUM, a.*
 FROM (SELECT movie_name, MOVIE_VIEWCNT, MOVIE_OPENDATE, MOVIE_CODE
 FROM MOVIE
 ORDER BY MOVIE_VIEWCNT DESC) a
WHERE ROWNUM <=10;

SELECT ROWNUM, a.*
FROM (SELECT *
        FROM movie
        WHERE type_lgu =130
            or type_lgu = 140
            or type_lgu = 150
        ORDER BY movie_score desc)a
WHERE ROWNUM < 11;

SELECT ROWNUM, a.*, b.type_name
FROM(
    SELECT *
    FROM (  SELECT *
            FROM MOVIE
            WHERE TYPE_LGU = '130'
            ORDER BY MOVIE_SCORE DESC
    )
    WHERE ROWNUM <= 5
    UNION ALL
    SELECT *
    FROM (  SELECT *
            FROM MOVIE
            WHERE TYPE_LGU = '140'
            ORDER BY MOVIE_SCORE DESC
    )
    WHERE ROWNUM <= 3
    UNION ALL
    SELECT *
    FROM (  SELECT *
            FROM MOVIE
            WHERE TYPE_LGU = '150'
            ORDER BY MOVIE_SCORE DESC
    )
    WHERE ROWNUM <= 2) a, TYPE b
WHERE a.type_lgu = b.type_lgu;

SELECT rownum, a.*, b.* 
FROM movie a, type b
WHERE a.type_lgu = b.type_lgu
    AND movie_name like '%¸¶%';
