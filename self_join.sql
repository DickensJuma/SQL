-- Question 1
SELECT COUNT(name)
FROM stops;

-- Question 2
SELECT id
FROM stops
WHERE stops.name = 'Craiglockhart';

-- Question 3
SELECT id, name
FROM stops 
INNER JOIN route 
ON id = route.stop
WHERE route.num = '4' 
AND route.company = 'LRT'

-- Question 4
SELECT company, num, COUNT(*) AS stops
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING stops > 1;

-- Question 5
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b 
ON (a.company=b.company AND a.num=b.num)
WHERE a.stop=53
AND b.stop = 149;

-- Question 6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name = 'London Road';

-- Question 7
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=115
AND b.stop = 137;

-- Question 8
SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name = 'Tollcross';

-- Question 9
SELECT stopb.name, a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart';

-- Question 10
SELECT bus1.busnumber AS 'num', bus1.company, bus2.transfer AS 'name', bus2.busnumber AS 'num', bus2.company 
  FROM (SELECT r1.num AS 'busnumber', r1.company AS 'company', r2.stop AS 'stopp' FROM route r1 
  JOIN route r2 ON (r1.num = r2.num AND r1.company = r2.company) JOIN stops s1 ON s1.id = r1.stop
  JOIN stops s2 ON s2.id = r2.stop WHERE s1.name = 'Craiglockhart') bus1
  JOIN
  (SELECT s1.name AS 'transfer', r1.num AS 'busnumber', r1.company AS 'company', r1.stop AS 'stopp', r1.pos AS 'pos' 
  FROM route r1 JOIN route r2 ON (r1.num = r2.num AND r1.company = r2.company) JOIN stops s1 ON s1.id = r1.stop
  JOIN stops s2 ON s2.id = r2.stop WHERE s2.name = 'Lochend') bus2
  ON bus1.stopp = bus2.stopp ORDER BY bus1.busnumber, name, 4;