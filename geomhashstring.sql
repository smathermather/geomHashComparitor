/*example usage:
WITH unioned AS (
	SELECT ST_Union(geom) AS geom FROM royalview)
SELECT geohashstring(geom) FROM unioned

-- returns e.g. "dpmfftpydjn7fshmd616,dpmfftpydrb38qu2334f,dpmf (...)"
*/

CREATE OR REPLACE FUNCTION geohashstring (geometry) RETURNS text AS $$
 
WITH unionT AS (
	SELECT ST_Transform($1, 4326) AS geom)
,geohash AS (
	SELECT ST_GeoHash((ST_DumpPoints(geom)).geom) AS hash FROM unionT )

SELECT STRING_AGG(hash, ',') FROM geohash;
 
$$ LANGUAGE SQL;

