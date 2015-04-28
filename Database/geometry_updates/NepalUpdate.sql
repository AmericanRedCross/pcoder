-- SQL Script for Dropping GADM 1 thru 4 Nepal Data and Inserting HDX Data with PCodes.


--Level 0
--Just add PCode to GADM0 pcode column
Update gadm0
set pcode = 'NP'
where name_0 = 'Nepal'


--Level 1
select * from hdx_nepal_level1

-- Drop Old Rows from GADM for Nepal
Delete from gadm1
where name_0 = 'Nepal'

INSERT INTO gadm1 (name_0, name_1, geom, year, geom_simplify_med, pcode)
(SELECT 'Nepal', hrname, geom, 2014, geom, hrpcode  from hdx_nepal_level1)





--Level 2


select * from hdx_nepal_level2
order by hrname

select * from gadm2
where name_0 = 'Nepal'

-- Drop Old Rows from GADM for Nepal
Delete from gadm2
where name_0 = 'Nepal'

INSERT INTO gadm2 (name_0, name_1, name_2, geom, year, geom_simplify_med, pcode)
(SELECT 'Nepal', '', hrname, geom, 2014, geom, hrpcode from hdx_nepal_level2)

--Now, backfill in Level2 name_1 column
Update gadm2 a
SET name_1 = (
SELECT hdx_nepal_level1.hrname
FROM hdx_nepal_level1
INNER JOIN hdx_nepal_level2
ON (hdx_nepal_level2.hrparent = hdx_nepal_level1.hrpcode)
INNER JOIN gadm2
ON (gadm2.pcode = hdx_nepal_level2.hrpcode)
AND gadm2.name_0 = 'Nepal'
AND a.name_2 = gadm2.name_2
)
WHERE a.name_0 = 'Nepal'



--Level 3
--Just joined on name and country, updated geom and pcode values
--Most names match.  Update the 3 that don't.
-- Then Join

select * from hdx_nepal_level3
order by hrname

Select * from hdx_nepal_level3
WHERE district NOT IN (select name_3 from gadm3 where name_0 = 'Nepal')

Update gadm3
set name_3 = 'Kabhrepalanchok'
where id = 92898

Update gadm3
set name_3 = 'Dhanusha'
where id = 41470

Update gadm3
set name_3 = 'Makawanpur'
where id = 33085

--Verify the matches before updating
Select * from gadm3
--SET geom = hdx.geom, pcode = hdx.hrpcode, geom_simplify_med = hdx.geom
,hdx_nepal_level3 hdx
WHERE hdx.district = name_3
AND name_0 = 'Nepal'

UPDATE gadm3
SET geom = hdx.geom, pcode = hdx.hrpcode, geom_simplify_med = hdx.geom
FROM hdx_nepal_level3 hdx
WHERE hdx.district = name_3
AND name_0 = 'Nepal'


--Fill in level 1 names in the level 3 table
UPDATE gadm3 a
SET name_1 = (SELECT DISTINCT (gadm2.name_1)
FROM gadm2
WHERE gadm2.name_2 = a.name_2
AND gadm2.name_0 = 'Nepal')
WHERE a.name_0 = 'Nepal'

--Since 'Dhaualagiri' is missing a name in the ref table, update it separately
Update gadm3
Set name_1 = 'Western'
WHERE name_2 = 'Dhaualagiri'
And name_0 = 'Nepal'



--Level 4
-- Too many differences.  Drop old nepal and load new one.

--browse
select * from hdx_nepal_level4
order by vdc_name

--Just to see
Select * from gadm4
where name_0 = 'Nepal'

--Drop old
Delete from gadm4
where name_0 = 'Nepal'

--Load new
INSERT INTO gadm4 (name_0, name_1, name_2, name_3, name_4, geom, year, geom_simplify_med, pcode)
(SELECT 'Nepal', '', zone, dist_name, vdc_name, geom, 2014, geom, ocha_pcode  from hdx_nepal_level4)

--Fill in level 1 names in the level 3 table
UPDATE gadm4 a
SET name_1 = (SELECT DISTINCT (gadm3.name_1)
FROM gadm3
WHERE gadm3.name_3 = a.name_3
AND gadm3.name_0 = 'Nepal')
WHERE a.name_0 = 'Nepal'




