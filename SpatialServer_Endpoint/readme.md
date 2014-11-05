—This file is a Geoprocessing operation for SpatialServer.

—To use, install SpatialServer (https://github.com/spatialdev/PGRestAPI), copy and fill in settings.example.js (rename to settings.js)

—These particular .js files are expecting specific data from the redcross_pcodes database hosted on an Amazon RDS PostGreSQL instance.

—Drop these .js files in /endpoints/geoprocessing/operations
—Then restart the server.



—Pass in an X and Y (Decimal Degrees) and get back the Admin Stack including pcodes (where they exist).

Example usage:
http://geo.redcross.org:3001/services/geoprocessing/geoprocessing_operation?name=getpcodestackbyxy&x=-9.584793&y=6.944435&format=geojson


