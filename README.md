geomHashComparitor
==================

Some magic for doing fuzzy and shaven comparisons of geometries.

In short this will be a PostgreSQL function for comparing geometries.  Each point in the geometries will be fed through ST_GeoHash, and the resulting strings will be compared at multiple lenghts of geohash in order to determine similarity.

From the postgis docs:
"A GeoHash encodes a point into a text form that is sortable and searchable based on prefixing. A shorter GeoHash is a less precise representation of a point. It can also be thought of as a box, that contains the actual point."

In short, this approach is conceptually similar to rasterizing the vector geometries and comparing the resultant rasters pixel by pixel to find differences, and doing that at multiple resolutions.

USAGE:

This will require the use of pg_trgm.  To install pg_trgm, simply run the following against your database:
```SQL
CREATE EXTENSION pg_trgm;
```


And now we can use _similarity_ in conjunction with our new function:
```SQL
WITH sim01 AS (
	SELECT base.geohashstring(ST_Union(geom)) AS string1 FROM base.royalview
	),
sim02 AS (
	SELECT base.geohashstring(ST_Union(geom)) AS string2 FROM base.royalview_hand
	)
	
SELECT similarity(string1, string2) FROM sim01, sim02;
```
