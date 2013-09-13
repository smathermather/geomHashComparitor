CREATE OR REPLACE FUNCTION geohashstring (geometry) RETURNS text AS $$
 
WITH royalview2 AS (
	SELECT ST_Transform(ST_Union(geom), 4326) AS geom FROM royalview)
,royalview2_hand AS(
	SELECT ST_Transform(ST_Union(geom), 4326) AS geom FROM royalview_hand)
,geohash AS (
	SELECT ST_GeoHash((ST_DumpPoints(geom)).geom) AS hash FROM royalview2)

SELECT STRING_AGG(hash, ',') FROM geohash;
 
$$ LANGUAGE SQL;