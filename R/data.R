#' tax slabs with updated tax rate
#' @export
#'
data.tax_slabs <- cbind.data.frame(
  income = c("annual income <= 2.5L",
             "2.5L > annual income <= 5L",
             "5L > annual income <= 7.5L",
             "7.5 > annual income <= 10L",
             "10L > annual income <= 15L",
             "annual income > 15L"),
  taxOld = c(0, 0.05, 0.075, 0.100, 0.20, 0.30),
  taxNew = c(0, 0.00, 0.050, 0.075, 0.10, 0.20))
