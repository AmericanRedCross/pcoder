PCoder Database
========================

The PCoder database is a PostGreSQL/PostGIS instance running on an Amazon RDS instance.
The tables are as follows:

* gadm0
* gadm1
* gadm2
* gadm3
* gadm4
* gadm5
* gadmrollup

The underlying boundary dataset is [GADM](http://www.gadm.org), 2014 release.

Note that Guinea has been dropped and updated with WFP data as of December 2014 (for this instance only). It was found to be more up-to-date, especially in Conakry, and contains correct p-codes for the entire country.  However, the geometry doesn’t align exactly with GADM geometry.

Although GADM tables have up to level 5 geometries for some areas of the world, we only have p-codes for the following districts and levels:

* Guinea - Level 0,1,2 and 3
* Sierra Leone - Level 0, 1 and 2
* Liberia - Level 0 and 1

The main modification that was made to the GADM tables was the addition of a ‘pcode’ column.


## Updating the Database with-pcodes

GADM tables do not know about p-codes.  They must be added to the dataset for the current setup to work.

A new pcode (character varying) column was added to each GADM table.  Most fields are blank.

To add new countries/districts to the PCoder service, add the correct p-codes to the pcode column in each GADM table that is applicable.

When all updates have been made, [a script](https://github.com/AmericanRedCross/pcoder/tree/master/Database/setup/gadmrollup_byName.sql) is run that drops and rebuilds a table called ‘gadmrollup’.
This table contains 1 row per ‘stack’ of nested administrative boundaries.  It is this table that is used by the PCoder web services.





## Substituting old geometry with new geometry

In the case of Guinea, we discovered that the boundaries around Conakry weren’t as up-to-date as the WFP Guinea dataset.

So, we dropped the GADM Guinea data for levels 0 thru 3 and INSERTED WFP data.

Here’s how we did it.

1. Using [QGIS](http://www.qgis.org/), I loaded the updated .geojson data for Guinea to make sure the data was located in the correct place.  It had been graciously split up into individual levels/dissolved beforehand.  [Guinea .geojson data](https://gist.github.com/samuelestabrook/371b1178871a359003b9) You can drag/drop each .geojson file into QGIS to create a new layer.

2. In QGIS, I exported each layer to an ESRI Shapefile by right-clicking on the layer and choosing ‘Save As’ and then ‘ESRI Shapefile’.

3. Using pgShapeLoader (installed as part of the [PostGIS](http://postgis.net/) installer), I imported each shapefile into my PostGIS Database. Each shapefile becomes its own table.  I named the tables `corrected_guinea_level0` thru `corrected_guinea_level3`.

4. Using [another sql script](https://github.com/AmericanRedCross/pcoder/tree/master/Database/geometry_updates/GuineaUpdate.sql), I dropped from each GADM table any row where the country name was ‘Guinea’.  Next, I selected the new WFP geometries from `corrected_guinea_level0` thru `corrected_guinea_level3` and `INSERT`ed them into the GADM table.  Note that the `corrected_guinea_level0` tables don’t contain GUIDs or id columns like the GADM tables. These columns are skipped during the `SELECT`ion process.

5. When all updates have been made, [a script](https://github.com/AmericanRedCross/pcoder/tree/master/Database/setup/gadmrollup_byName.sql) is run that drops and rebuilds a table called ‘gadmrollup’. This table contains 1 row per ‘stack’ of nested administrative boundaries.  It is this table that is used by the PCoder web services.




