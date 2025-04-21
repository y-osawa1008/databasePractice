-- 問1
-- 国名を全て抽出してください。
SELECT name FROM countries;

-- 問2
-- ヨーロッパに属する国をすべて抽出してください。
SELECT name FROM countries WHERE continent = 'Europe';

-- 問3
-- ヨーロッパ以外に属する国をすべて抽出してください。
SELECT name FROM countries WHERE continent != 'Europe'; --"!"は～以外の

-- 問4
-- 人口が10万人以上の国をすべて抽出してください。
SELECT name FROM countries WHERE population >= '100000'; --">="は〇〇以上

-- 問5
-- 平均寿命が56歳から76歳の国をすべて抽出してください。
SELECT name FROM countries WHERE life_expectancy BETWEEN 56 AND 76; --"BETWEENは"～の間

-- 問6
-- 国コードがNLB,ALB,DZAのもの市区町村をすべて抽出してください。
SELECT district FROM cities WHERE country_code IN ('NLB','ALB','DZA');
--コマンドで「\d countries」カラム構造を確認
--countriesにdistrictの列(カラム)がないため、ほかのテーブルでカラム構造を確認「\d cities」
--また、「OR」を使った記述もできるが、「IN」のほうが見やすい

-- 問7
-- 独立独立記念日がない国をすべて抽出してください。
SELECT name FROM countries WHERE indep_year IS NULL; 
--"IS"演算子はNULLを比較するときに使う
--"IS NOT NULL"はその逆

-- 問8
-- 独立独立記念日がある国をすべて抽出してください。
SELECT name FROM countries WHERE indep_year IS NOT NULL;

--
-- 問9
-- 名前の末尾が「ia」で終わる国を抽出してください。
SELECT name FROM countries WHERE name LIKE '%ia'; --「%」はワイルドカードで任意の文字列にマッチ
--SQLの LIKE は、文字列パターンにマッチするデータを検索するための比較演算子

-- 問10
-- 名前の中に「st」が含まれる国を抽出してください。
SELECT name FROM countries WHERE name LIKE '%st%';
--%st% は「st」がどこにあってもOK（前後に何かあってもよい）という意味。

-- 問11
-- 名前が「an」で始まる国を抽出してください。
SELECT name FROM countries WHERE name LIKE 'an%';

-- 問12
-- 全国の中から独立記念日が1990年より前または人口が10万人より多い国を全て抽出してください。
SELECT name FROM countries WHERE indep_year < '1990' OR population > 100000;

-- 問13
-- コードがDZAもしくはALBかつ独立記念日が1990年より前の国を全て抽出してください。
SELECT name FROM countries WHERE code IN ('DZA','ALB') AND indep_year < '1990';
--国コードが「country_code」ではなく、「code」だと間違えないよう注意

-- 問14
-- 全ての地方をグループ化せずに表示してください。
SELECT region FROM countries;

-- 問15
-- 国名と人口を以下のように表示させてください。シングルクォートに注意してください。
-- 「Arubaの人口は103000人です」
SELECT name || 'の人口は' || population || '人です。' FROM countries ;

-- 問16
-- 平均寿命が短い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT name FROM countries WHERE life_expectancy IS NOT NULL
ORDER BY life_expectancy ASC;
--WHERE文でNULLを非表示、そのあとにORDER BY文

-- 問17
-- 平均寿命が長い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT name FROM countries WHERE life_expectancy IS NOT NULL
ORDER BY life_expectancy DESC;

-- 問18
-- 平均寿命が長い順、独立記念日が新しい順に国を表示させてください。
SELECT name FROM countries ORDER BY life_expectancy DESC, indep_year DESC;

-- 問19
-- 全ての国の国コードの一文字目と国名を表示させてください。
SELECT LEFT(code, 1) AS code_first_char, name FROM countries;
--LEFT() 関数は、指定した文字列の先頭から指定した数だけ文字を切り取るため
--AS は、SQLでカラムやテーブルに別名（エイリアス）をつけるためのキーワード
--first_char は、このクエリで指定したエイリアス名

-- 問20
-- 国名が長いものから順に国名と国名の長さを出力してください。
SELECT name, LENGTH(name) AS name_length FROM countries ORDER BY name_length DESC;

-- 問21
-- 全ての地方の平均寿命、平均人口を表示してください。(NULLも表示)
SELECT region, AVG(life_expectancy) AS "平均寿命", AVG(population) AS "平均人口"
FROM countries GROUP BY region;
--AVG 関数 は、「平均値（へいきんち）」を計算するための関数

-- 問22
-- 全ての地方の最長寿命、最大人口を表示してください。(NULLも表示)
SELECT region, MAX(life_expectancy) AS "最長寿命", MAX(population) AS "最大人口"
FROM countries GROUP BY region;
--MAX関数 は、「最大値」を計算するための関数

-- 問23
-- アジア大陸の中で最小の表面積を表示してください
SELECT surface_area
FROM countries
WHERE continent = 'Asia'
ORDER BY surface_area ASC
LIMIT 1; --LIMITは表示する行数

-- 問24
-- アジア大陸の表面積の合計を表示してください。
SELECT SUM(surface_area) AS "アジア大陸表面積合計"
FROM countries
WHERE continent = 'Asia';

-- 問25
-- 全ての国と言語を表示してください。一つの国に複数言語があると思いますので同じ国名を言語数だけ出力してください。
SELECT c.name, cl.language
FROM countries c --「AS」はあってもなくても良い
JOIN country_languages cl
ON c.code = cl.country_code;

-- 問26
-- 全ての国と言語と市区町村を表示してください。
SELECT c.name AS "国", ci.name AS "市区町村", cl.language
FROM countries c
JOIN cities ci 
ON c.code = ci.country_code
JOIN country_languages cl 
ON c.code = cl.country_code;
-- 問27
-- 全ての有名人を出力してください。左側外部結合を使用して国名なし（country_codeがNULL）も表示してください。
SELECT celebrities.name AS 有名人, countries.name AS 国
FROM celebrities 
LEFT OUTER JOIN countries
ON celebrities.country_code = countries.code;

-- 問28
-- 全ての有名人の名前,国名、第一言語を出力してください。
SELECT celebrities.name AS 有名人, countries.name AS 国, country_languages.language AS 第一言語
FROM celebrities
JOIN countries ON celebrities.country_code = countries.code
JOIN country_languages ON countries.code = country_languages.country_code
WHERE country_languages.is_official = 'T';
--3テーブルを結合、'T'=True(公式言語)を表す

-- 問29
-- 全ての有名人の名前と国名を出力してください。 ただしテーブル結合せずサブクエリを使用してください。
SELECT 
name AS 有名人,
(
    SELECT name 
    FROM countries 
    WHERE countries.code = celebrities.country_code
) AS 国名
FROM 
celebrities;

-- 問30
-- 最年長が50歳以上かつ最年少が30歳以下の国を表示させてください。
SELECT country_code FROM celebrities
GROUP BY country_code
HAVING MAX(age) >= 50 AND MIN(age) <= 30;

-- 問31
-- 1991年生まれと、1981年生まれの有名人が何人いるか調べてください。ただし、日付関数は使用せず、UNION句を使用してください。
SELECT '1991' AS 誕生年, COUNT(*) AS 人数
FROM celebrities WHERE EXTRACT(YEAR FROM birth) = 1991
UNION
SELECT '1981' AS 誕生年, COUNT(*) AS 人数
FROM celebrities WHERE EXTRACT(YEAR FROM birth) = 1981;

-- 問32
-- 有名人の出身国の平均年齢を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
SELECT  countries.name AS 国名, 
        AVG(celebrities.age) AS 平均年齢
FROM countries
JOIN celebrities ON countries.code = celebrities.country_code
GROUP BY 国名
ORDER BY 平均年齢 DESC;