PCoder
========================

Pcoder is a set of web services that allow for spatial querying of administrative boundaries tagged with [p-codes](https://sites.google.com/site/ochaimwiki/geodata-preparation-manual/p-code-guidelines).

Currently, Guinea, Sierra Leone and Liberia contain p-codes, though there are gaps in coding depending on the country.

* Guinea - Level 0,1 and 2
* Sierra Leone - Level 0, 1 and 2
* Liberia - Level 0 and 1

The underlying boundary dataset is [GADM](http://www.gadm.org), 2014 release.



# Services

There are 3 services:

###GetPCodeStackByXY
This service expects a single location to be passed in, and will return the 'stack' of administrative boundaries (including pcodes where available) that touch that location.

####Parameters
- **x** - required. The x or longitudinal coordinate, specified in WGS84 (Latitude/Longitude) and in decimal degrees.
- **y** - required. The y or latitude coordinate, specified in WGS84 (Latitude/Longitude) and in decimal degrees.
- **format** - required. `geojson` or `csv` (Note: when returnGeometry=true, csv format doesn't properly display the geometries)
- **name** - required. "getpcodestackbyxy".  All endpoints require the name of the operation to be specified.
- **returnGeometry** - optional. `true` or `false`.  Whether or not to return a geometryCollection of the intersected boundaries. Defaults to false.

####GET Example

######Pass in an x and y, output format = geojson, no geometry
    https://geo.redcross.org/pcodes/services/geoprocessing/geoprocessing_operation?name=getpcodestackbyxy&x=-9.584793&y=6.944435&format=geojson&returnGeometry=false

Response:

    {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "properties": {
            "name0": "Guinea",
            "guid0": "210a1247-3146-4705-b3cf-3dbbdc2a5e5d",
            "pcode0": "GIN",
            "name1": "Kankan",
            "guid1": "bfb632db-5e13-414e-8a77-a217f2034888",
            "pcode1": "GIN004",
            "name2": "Kérouané",
            "guid2": "a176034b-06dd-4253-a742-b4407576d5af",
            "pcode2": "GIN004002",
            "name3": "Kounsankoro",
            "guid3": "6c4d08cc-e206-4c10-a4d4-a212d82fb2da",
            "pcode3": null,
            "name4": null,
            "guid4": null,
            "pcode4": null,
            "name5": null,
            "guid5": null,
            "pcode5": null
          }
        }
      ]
    }

####POST Example
Using jQuery, here is an example of POSTing to this endpoint:

    //define arguments
    var args = {
        format: 'geojson',
        x: -11.648737,
        y: 8.280284,
        returnGeometry: false,
        name: "getpcodestackbyxy"
    };

    //jQuery POST
    $.post('https://geo.redcross.org/pcodes/services/geoprocessing/geoprocessing_operation', args).done(function (data) {
        //Callback on success
        console.log(data);
    })





###GetPCodeStackByXYList
This service expects a delimited list of locations to be passed in, and will return the 'stack' of administrative boundaries (including pcodes where available) that touch those locations.

####Parameters
- **coords** - required. An X Y (Longitude Latitude) coordinate list in the form X Y,X Y,X Y,X Y,X Y.  Coordinates should be in WGS84 decimal degrees.
- **format** - required. `geojson` or `csv` (Note: when returnGeometry=true, csv format doesn't properly display the geometries)
- **name** - required. "getpcodestackbyxylist".  All endpoints require the name of the operation to be specified.
- **returnGeometry** - optional. `true` or `false`.  Whether or not to return a geometryCollection of the intersected boundaries. Defaults to false.

####GET Example

######Pass in list of x y coordinates, output format = geojson, no geometry
Coordinates are: -11.648737 8.280284,-12.077204 9.539293,-10.637995 8.236794
(Note: Spaces in the x y,x y list are encoded when being displayed in the URL.  So a space is transformed into %20)

    https://geo.redcross.org/pcodes/services/geoprocessing/geoprocessing_operation?name=getpcodestackbyxylist&coords=-11.648737%208.280284%2C-12.077204%209.539293%2C-10.637995%208.236794&returnGeometry=false&format=geojson

Response:

    {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "properties": {
            "name0": "Sierra Leone",
            "guid0": "d0360513-1308-4f96-908e-2b2d7420761a",
            "pcode0": "SL",
            "name1": "Eastern",
            "guid1": "bf6756d6-edbc-4865-8ac6-2d069eda4e6c",
            "pcode1": "SLE01",
            "name2": "Kailahun",
            "guid2": "356df806-647c-46ac-a8dc-159ba50e94be",
            "pcode2": "SLE0101",
            "name3": "Luawa",
            "guid3": "a2a154e1-9978-47e1-ac22-ac777790d060",
            "pcode3": null,
            "name4": null,
            "guid4": null,
            "pcode4": null,
            "name5": null,
            "guid5": null,
            "pcode5": null
          },
          "geometry": {
            "type": "GeometryCollection",
            "geometries": [
              null,
              null,
              null,
              null,
              null,
              null
            ]
          }
        },
        {
          "type": "Feature",
          "properties": {
            "name0": "Sierra Leone",
            "guid0": "d0360513-1308-4f96-908e-2b2d7420761a",
            "pcode0": "SL",
            "name1": "Northern",
            "guid1": "cb9c2551-b662-47d7-a828-3d08273edb48",
            "pcode1": "SLE02",
            "name2": "Bombali",
            "guid2": "ebab0144-082a-4e71-9828-d844bd8da119",
            "pcode2": "SLE0201",
            "name3": "Sella Limba",
            "guid3": "b8c9a879-1684-4d65-aa02-badad45b535f",
            "pcode3": null,
            "name4": null,
            "guid4": null,
            "pcode4": null,
            "name5": null,
            "guid5": null,
            "pcode5": null
          },
          "geometry": {
            "type": "GeometryCollection",
            "geometries": [
              null,
              null,
              null,
              null,
              null,
              null
            ]
          }
        },
        {
          "type": "Feature",
          "properties": {
            "name0": "Sierra Leone",
            "guid0": "d0360513-1308-4f96-908e-2b2d7420761a",
            "pcode0": "SL",
            "name1": "Southern",
            "guid1": "93f02157-ff7a-447c-886a-7d2df2f766a1",
            "pcode1": "SLE03",
            "name2": "Bo",
            "guid2": "d54809dc-990f-4eeb-8af0-0801007e182b",
            "pcode2": "SLE0301",
            "name3": "Valunia",
            "guid3": "92a58576-d539-4feb-b578-8b8033de7b8b",
            "pcode3": null,
            "name4": null,
            "guid4": null,
            "pcode4": null,
            "name5": null,
            "guid5": null,
            "pcode5": null
          },
          "geometry": {
            "type": "GeometryCollection",
            "geometries": [
              null,
              null,
              null,
              null,
              null,
              null
            ]
          }
        }
      ]
    }



####POST Example
Using jQuery, here is an example of POSTing to this endpoint:

    //define arguments
    var args = {
        format: 'geojson',
        coords: "-11.648737 8.280284,-12.077204 9.539293,-10.637995 8.236794",
        returnGeometry: false,
        name: "getpcodestackbyxylist"
    };

    //jQuery POST
    $.post('https://geo.redcross.org/pcodes/services/geoprocessing/geoprocessing_operation', args).done(function (data) {
        //Callback on success
        console.log(data);
    })






###UploadCSVToPCode

POST a Comma Separated Value (.csv) file containing x and y coordinates to this service, and it will return the 'stack' of administrative boundaries (including pcodes where available) that touch locations in the csv.

Currently, it is required that the csv contain an `x` and `y` column that contain longitude and latitude values, respectively.

Other columns pass through unaffected, and are included in the output.

####Parameters
- **csvupload** - required. The CSV file being posted should be passed using this parameter name
- **format** - required. `geojson` or `csv`
- **name** - required. "uploadcsvtopCode".  All endpoints require the name of the operation to be specified.

####POST Example

######Pass in list csv from HTML file picker, output format = csv

[Example Input CSV](https://github.com/AmericanRedCross/pcoder/tree/master/DocSupport/example_csv/input.csv)


    <html>
        <head>
           <title>PCoder Example</title>
           <meta charset="utf-8">
           <meta name="viewport" content="width=device-width, initial-scale=1.0">
        </head>
        <body>
            <form action="https://geo.redcross.org/pcodes/services/geoprocessing/geoprocessing_operation" method="POST" enctype="multipart/form-data">
               <input type="file" name="csvupload">
               <input type="hidden" name="name" value="UploadCSVToPCode">
               <input type="hidden" name="format" value="csv">
               <button type="submit" class="btn">Submit</button>
            </form>
        </body>
    </html>

Response:

[Example Ouptut CSV](https://github.com/AmericanRedCross/pcoder/tree/master/DocSupport/example_csv/output.csv)
