# rwkt

R package for converting WKT to GeoJSON

## Install

```R
library(devtools)
install_github("pieterprovoost/rwkt")
```

## Usage

```R
data <- "MULTIPOLYGON (((102 2,103 2,103 3,102 3,102 2)),
  ((100 0,101 0,101 1,100 1,100 0),(100.2 0.2,100.8 0.2,100.8 0.8,100.2 0.8,100.2 0.2)))"
geojson(data)
```

````
{"type":"Feature","geometry":{"type":"MultiPolygon","coordinates":[[[[102,2],[103,2],[103,3],[102,3],[102,2]]],[[[100,0],[101,0],[101,1],[100,1],[100,0]],[[100.2,0.2],[100.8,0.2],[100.8,0.8],[100.2,0.8],[100.2,0.2]]]]},"properties":[]}
```
