library(rwkt)
context("WKT")

test_that("conversions don't produce errors", {
  
  data <- "POINT (30 10)"
  geojson(data)
  data <- "GEOMETRYCOLLECTION(POINT(4 6),LINESTRING(4 6,7 10))"
  geojson(data)
  data <- "POLYGON ((10 10, 110 10, 110 110, 10 10), (20 20, 20 30, 30 30, 20 20), (40 20, 40 30, 50 30, 40 20))"
  geojson(data)
  data <- "MULTIPOLYGON (((30 20, 45 40, 10 40, 30 20)), ((15 5, 40 10, 10 20, 5 10, 15 5)))"
  geojson(data)
  data <- "MULTIPOLYGON (((102 2,103 2,103 3,102 3,102 2)),((100 0,101 0,101 1,100 1,100 0),(100.2 0.2,100.8 0.2,100.8 0.8,100.2 0.8,100.2 0.2)))"
  geojson(data)
  
})