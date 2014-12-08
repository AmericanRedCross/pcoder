--Level 0 was edited manually in QGIS by editing the gadm0 table, and pasting the level 0 feature from the GEOJSON Layer.
--Attributes were manually entered.

--Level 1
--Delete from gadm1
--where name_0 = 'Guinea'

Select * from corrected_guinea_level1
where cntry_name = 'Guinea' 
AND cntry_name NOT IN (select name_1 from gadm1 where name_0 = 'Guinea')

select * from gadm1 where name_0 = 'Guinea';

INSERT INTO gadm1 (name_0, name_1, geom, year, geom_simplify_med, pcode)
(SELECT cntry_name, adm1_name, geom, 2014, geom, adm1_pcode  from corrected_guinea_level1 where cntry_name = 'Guinea')



--Level2
--Delete from gadm2
--where name_0 = 'Guinea'

Select * from corrected_guinea_level2
where cntry_name = 'Guinea' 
AND adm2_name NOT IN (select name_2 from gadm2 where name_0 = 'Guinea')


INSERT INTO gadm2 (name_0, name_1, name_2, geom, year, geom_simplify_med, pcode)
(SELECT cntry_name, adm1_name, adm2_name, geom, 2014, geom, adm2_pcode  from corrected_guinea_level2 where cntry_name = 'Guinea')



--Level3
Delete from gadm3
where name_0 = 'Guinea'

Select * from corrected_guinea_level3
where cntry_name = 'Guinea' 
AND adm3_name NOT IN (select name_3 from gadm3 where name_0 = 'Guinea')


INSERT INTO gadm3 (name_0, name_1, name_2, name_3, geom, year, geom_simplify_med, pcode)
(SELECT cntry_name, adm1_name, adm2_name, adm3_name, geom, 2014, geom, adm3_pco_1  from corrected_guinea_level3 where cntry_name = 'Guinea')