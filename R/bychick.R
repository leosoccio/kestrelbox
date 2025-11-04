#' Kestrel nesting data organized by chick
#'
#' A dataset containing nesting data for kestrel chicks in Pennsylvania and New Jersey. Each row represents one chick.
#' 
#' @format A data frame with 2027 rows and 8 variables:
#' \describe{
#'   \item{box_id}{ID number for the box the chick was nesting in for compatability with the bybox dataset}
#'   \item{year}{The year in which the chick was observed} 
#'   \item{age}{Age of the chick when banded, in days}
#'   \item{weight}{Weight of the chick when banded, in grams}
#'   \item{band_date}{Date on which the chick was banded}
#'   \item{fledge_date}{Date on which the chick turned 30 days old}
#'   \item{sex}{Sex of the chick. M for male, F for female, U for unknown sex}
#'   \item{study_area}{Indicates whether the chick was in central PA, New Jersey, or Lancaster, PA}
#' }
#' @source Kestrel data collected by Steve Eisenhauer.
"bychick"