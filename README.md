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
cat(geojson(data))
```

```json
{
    "type": "Feature",
    "geometry": {
        "type": "MultiPolygon",
        "coordinates": [
            [
                [
                    [
                        102,
                        2
                    ],
                    [
                        103,
                        2
                    ],
                    [
                        103,
                        3
                    ],
                    [
                        102,
                        3
                    ],
                    [
                        102,
                        2
                    ]
                ]
            ],
            [
                [
                    [
                        100,
                        0
                    ],
                    [
                        101,
                        0
                    ],
                    [
                        101,
                        1
                    ],
                    [
                        100,
                        1
                    ],
                    [
                        100,
                        0
                    ]
                ],
                [
                    [
                        100.2,
                        0.2
                    ],
                    [
                        100.8,
                        0.2
                    ],
                    [
                        100.8,
                        0.8
                    ],
                    [
                        100.2,
                        0.8
                    ],
                    [
                        100.2,
                        0.2
                    ]
                ]
            ]
        ]
    },
    "properties": [
    ]
}
```

```R
data <- "GEOMETRYCOLLECTION(POINT(4 6),LINESTRING(4 6,7 10))"
cat(geojson(data))
```

```text
{"type":"FeatureCollection","features":[{"type":"Feature",
  "geometry":{"type":"Point","coordinates":[4,6]},"properties":[]},
  {"type":"Feature","geometry":{"type":"LineString","coordinates":[[4,6],[7,10]]},
  "properties":[]}]}
```
