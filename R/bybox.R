#' Kestrel nesting data organized by nesting box
#'
#' A dataset containing nesting box data for kestrels in Pennsylvania and New Jersey. Each row represents one nesting box.
#' 
#' @format A data frame with 1321 rows and 12 variables:
#' \describe{
#'   \item{box_id}{ID number for the box for compatability with the bychick dataset}
#'   \item{year}{The year in which the chick was observed} 
#'   \item{did_not_check}{Binary variable taking on 1 if the box was not checked that year and 0 if it was}
#'   \item{occupied}{Binary variable taking on 1 if the box was occupied that year and 0 if it wasn't}
#'   \item{failure}{Binary variable taking on 1 if chicks did not survive to fledging and 0 otherwise}
#'   \item{young_count}{Number of chicks in the box}
#'   \item{young_count_2nd_brood}{If there was a second brood that year, number of chicks in that brood}
#'   \item{unbanded_young_count}{Number of young who were not banded}
#'   \item{mount_type}{Indicates whether the box was mounted on a steel pole, public utility pole, private utility pole, or something else (other)}
#'   \item{study_area}{Indicates whether the box is in central PA, New Jersey, or Lancaster, PA}
#'   \item{latitude}{The latitude of the box, randomly jittered by up to 0.2 degrees}
#'   \item{longitude}{The longitude of the box, randomly jittered by up to 0.2 degrees}
#' }
#' @source Kestrel data collected by Steve Eisenhauer.
"bybox"