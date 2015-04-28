This file is a Geoprocessing operation for the GeoForce/Mapfolio instance of SpatialServer.

To use, install GeoForce/Mapfolio (https://github.com/spatialdev/PGRestAPI), copy and fill in settings.example.js (rename to settings.js)

These particular .js files are expecting specific data from the redcross_pcodes database hosted on an Amazon RDS PostGreSQL instance.

Drop these .js files in /endpoints/geoprocessing/operations

Next, edit the settings.js file and add an object to settings to store the pcode DB Connection info.

    settings.pcoderPG.username = "foo";
    settings.pcoderPG.password = "foo";
    settings.pcoderPG.server = "foo";
    settings.pcoderPG.port = "foo";
    settings.pcoderPG.database = "foo";


Then restart the server.




