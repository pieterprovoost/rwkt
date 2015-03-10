parsewkt <- function(str) {
  result <- list()
  children <- list()
  groups <- str_match(str, "([A-Za-z\\s]+)\\s*\\((.*)\\)")
  geometry <- groups[,2]
  content <- groups[,3]
  result[["name"]] <- geometry
  if (str_count(content, "[A-Za-z]") > 0) {
    contentgroups <- str_match_all(content, "[A-Za-z\\s]+\\s*\\(.*?\\),*")[[1]][,1]
    for (c in contentgroups) {
      children[[length(children) + 1]] <- parsewkt(c)
    }
    result[["children"]] <- children
  } else {
    result[["points"]] <- parsepoints(content)
  }
  return(result)
}

parsepoints <- function(points) {
  if (str_count(points, "\\(") > 0) {
    result <- list()
    open <- 0
    buffer <- ""
    for (i in seq(1, nchar(points))) {
      char <- substr(points, i, i)
      if (char == "(") {
        open <- open + 1
        if (open > 1) {
          buffer <- paste0(buffer, char)
        }
      } else if (char == ")") {
        open <- open - 1
        if (open > 0) {
          buffer <- paste0(buffer, char)
        }
        if (open == 0) {
          result[[length(result) + 1]] <- parsepoints(buffer)
          buffer <- ""
        }
      } else if (open > 0) {
        buffer <- paste0(buffer, char)
      }
    }
    return(result)
  } else {
    coords <- as.list(strsplit(points, ",")[[1]])
    coords <- lapply(coords, function(s) {str_replace_all(s, "^\\s+|\\s+$", "")})
    values <- lapply(coords, function(coord) {strsplit(coord, "\\s")[[1]]})
    for (i in seq(1, length(values))) {
      values[[i]] <- as.numeric(values[[i]])
    }
    return(values)
  }
}

objectify <- function(object, data) {
  output <- list()
  
  if (object$name == "GEOMETRYCOLLECTION") {
    
    output[["type"]] <- "FeatureCollection"
    for (c in seq(1, length(object$children))) {
      
      if (class(data) == "data.frame") {
        cdata <- as.list(data[c,])
      } else if (class(data) == "list") {
        cdata <- data
      }

      output [["features"]][[c]] <- objectify(object$children[[c]], cdata)
    }
    
  } else if (object$name == "POINT") {
    
    output[["type"]] <- "Feature"
    output[["geometry"]] <- list()
    output[["geometry"]][["type"]] <- "Point"
    output[["geometry"]][["coordinates"]] <- object$points[[1]]
    output[["properties"]] <- data
    
  } else if (object$name == "LINESTRING") {
    
    output[["type"]] <- "Feature"
    output[["geometry"]] <- list()
    output[["geometry"]][["type"]] <- "LineString"
    output[["geometry"]][["coordinates"]] <- object$points
    output[["properties"]] <- data
    
  } else if (object$name == "POLYGON") {
    
    output[["type"]] <- "Feature"
    output[["geometry"]] <- list()
    output[["geometry"]][["type"]] <- "Polygon"
    output[["geometry"]][["coordinates"]] <- object$points
    output[["properties"]] <- data
    
  } else if (object$name == "MULTIPOLYGON") {
    
    output[["type"]] <- "Feature"
    output[["geometry"]] <- list()
    output[["geometry"]][["type"]] <- "MultiPolygon"
    output[["geometry"]][["coordinates"]] <- object$points
    output[["properties"]] <- data
    
  }
  
  return(output)
}

#' Convert WKT to GeoJSON
#' 
#' @param input WKT string
#' @param pretty prettify JSON
#' @param data properties to be added, either a list or a data frame with one row per geometry in a geometry collection
#' @return GeoJSON string
geojson <- function(input, pretty=FALSE, data=list()) {
  
  p <- parsewkt(input)
  o <- objectify(p, data)
  
  return(toJSON(o, auto_unbox=TRUE, pretty=pretty))
  
}