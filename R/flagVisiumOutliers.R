#' Flag Visium Outliers in SpatialExperiment Objects
#'
#' The `flagVisiumoutliers` function identifies and flags Visium systematic outlier spots in a
#' `SpatialExperiment` object based on barcodes. These outliers are marked in the `colData`
#' of the `SpatialExperiment` object, allowing users to exclude them from downstream analyses
#' to enhance data quality and reliability.
#'
#' @param spe A `SpatialExperiment` object containing spatial transcriptomics data.
#'   The object must include `array_row` and `array_col` columns in its `colData` that
#'   specify the spatial coordinates of each spot.
#'
#' @return A `SpatialExperiment` object identical to the input `spe` but with an additional
#'   logical column `systematic_outliers` in its `colData`. This column indicates whether
#'   each spot is flagged as a technical outlier (`TRUE`) or not (`FALSE`).
#'
#' @importFrom utils data
#' @import SpatialExperiment
#'
#' @export
#'
#' @examples
#' library(SpotSweeper)
#' library(SpatialExperiment)
#'
#' # load example data
#' spe <- STexampleData::Visium_humanDLPFC()
#'
#' # Flag outlier spots
#' spe <- flagVisiumOutliers(spe)
#'
#' # drop outlier spots
#' spe <- spe[, !colData(spe)$systematic_outliers]
#'
flagVisiumOutliers <- function(spe) {

  # Check if 'spe' is (or inherits from) SpatialExperiment
  if (!inherits(spe, "SpatialExperiment")) {
    stop("Input data must be a SpatialExperiment or inherit from SpatialExperiment.")
  }

  # Load the biased_spots dataset
  data("biased_spots", package = "SpotSweeper", envir = environment())

  # Create a logical mask for cells to drop
  drop_mask <- rep(FALSE, ncol(spe))  # Start with a mask that keeps everything

  # For each pair of (row, col) in biased_spots, mark the matching cells for removal
  for (i in 1:nrow(biased_spots)) {
    row_match <- spe$array_row == biased_spots$row[i]
    col_match <- spe$array_col == biased_spots$col[i]

    # Mark cells for removal where both conditions are true
    drop_mask <- drop_mask | (row_match & col_match)
  }

  # Add the drop_mask as a new column in colData
  colData(spe)$systematic_outliers <- drop_mask

  return(spe)
}
