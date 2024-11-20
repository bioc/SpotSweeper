# SpotSweeper Package News

# Version 1.3.1

## Major Changes
- **Function Renaming**: The function `plotQC` has been renamed to `plotQCmetrics` to better reflect its purpose. The new function `plotQCmetrics` should be used moving forward. This change improves clarity in the package’s API by specifying that this function is designed for plotting QC metrics.


## New Features and Enhancements
- **`shape` argument**: Added a `shape` argument to `findArtifacts`, allowing users to specify the neighborhood shape as either `"hexagonal"` or `"square"` for local variance calculations. This enhancement provides flexibility for different spatial arrangements in spatial transcriptomics data.

- **Updated `n_order` parameter**: Renamed the `n_rings` parameter to `n_order` in the `findArtifacts` function to better describe its purpose of specifying the N-order neighbors for local mitochondrial variance calculations.

- **Parallelization**: Added a `workers` argument for parallel processing using `BiocParallel` in both `localOutlier` and `localVariance` functions. This allows for faster computation, particularly on larger datasets.

## Deprecations
- **`plotQC` Function Deprecated**: The `plotQC` function is now deprecated. While it remains available for backward compatibility, users are encouraged to transition to `plotQCmetrics`. Calling `plotQC` will display a warning, reminding users of the deprecation.

This change is backward compatible; existing code using `plotQC` will still work but will show a warning. We recommend updating your code to use `plotQCmetrics` to avoid any issues in future versions where `plotQC` may be removed.
