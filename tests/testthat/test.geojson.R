library(rwkt)
context("WKT")

test_that("input is converted as expected", {
  
  data <- "POINT (30 10)"
  g <- toGeoJSON(data)
  expect_equal(as.character(g), "{\"type\":\"Feature\",\"geometry\":{\"type\":\"Point\",\"coordinates\":[30,10]},\"properties\":[]}")
  
  data <- "GEOMETRYCOLLECTION(POINT(4 6),LINESTRING(4 6,7 10))"
  g <- toGeoJSON(data)
  #expect_identical(as.character(g), "")
  
  data <- "POLYGON ((10 10, 110 10, 110 110, 10 10), (20 20, 20 30, 30 30, 20 20), (40 20, 40 30, 50 30, 40 20))"
  g <- toGeoJSON(data)
  #expect_identical(as.character(g), "")
  
  data <- "MULTIPOLYGON (((30 20, 45 40, 10 40, 30 20)), ((15 5, 40 10, 10 20, 5 10, 15 5)))"
  g <- toGeoJSON(data)
  #expect_identical(as.character(g), "")
  
  data <- "MULTIPOLYGON (((102 2,103 2,103 3,102 3,102 2)),((100 0,101 0,101 1,100 1,100 0),(100.2 0.2,100.8 0.2,100.8 0.8,100.2 0.8,100.2 0.2)))"
  g <- toGeoJSON(data)
  #expect_identical(as.character(g), "")
  
})