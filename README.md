# rwkt

R package for converting WKT to GeoJSON

## Install

```R
library(devtools)
install_github("pieterprovoost/rwkt")
```

## Usage

```R
data <- "GEOMETRYCOLLECTION(POINT(4 6),LINESTRING(4 6,7 10))"
cat(geojson(data, pretty=TRUE, data=data.frame(a=c(1,2), b=c(3,4))))
```

```json
{
    "type": "FeatureCollection",
    "features": [
        {
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    4,
                    6
                ]
            },
            "properties": [
                {
                    "a": 1,
                    "b": 3
                }
            ]
        },
        {
            "type": "Feature",
            "geometry": {
                "type": "LineString",
                "coordinates": [
                    [
                        4,
                        6
                    ],
                    [
                        7,
                        10
                    ]
                ]
            },
            "properties": [
                {
                    "a": 2,
                    "b": 4
                }
            ]
        }
    ]
}
```
