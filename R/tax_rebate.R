utils:::globalVariables(c(
  "rebate_income_level_old", "rebate_income_level_new",
  "rebate_standard_deduction",
  "rebate_under_87A_old", "rebate_under_87A_new",
  "data.tax_rebate"))

#' @rdname tax_rebates
#' @export
#'
rebate_income_level_old <- 500000

#' @rdname tax_rebates
#' @export
#'
rebate_income_level_new <- 700000

#' @rdname tax_rebates
#' @export
#'
rebate_standard_deduction <- 50000

#' @rdname tax_rebates
#' @export
#'
rebate_under_87A_old <- 12500

#' @rdname tax_rebates
#' @export
#'
rebate_under_87A_new <- 25000

#' tax rebate with updated tax rate for FY 2022-23 (AY 2023-24)
#' @rdname tax_rebates
#' @export
#'
data.tax_rebate <- read.table(text = "
           id, what, regime_old, regime_new, particulars
           1, income_level, 500000, 700000, income level for rebate eligibility
           2, standard_deduction, 50000, 50000, standard deduction
           3, 80C, 150000, 0, investments
           4, 87A, 12500, 25000, rebate u/s 87A
           5, NPS, 50000, 0, employee’s (own) contribution to NPS
           6, 80D, 150000, 0, medical insurance premium
           7, 24B, 200000, 0, interest on Home Loan u/s 24b on slef-occupied or vacant property",
           header = TRUE, sep = ",")
