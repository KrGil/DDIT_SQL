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