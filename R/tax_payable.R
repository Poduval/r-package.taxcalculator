
#' @rdname tax_payable
#' @description Function to calculate final payable tax
#' @param x annual income
#' @param regime new or old
#' @year financial year for which tax needs to be calculated
#' @examples
#' tax_payable(2500000)
#'
#' @export
#'
tax_payable <- function(x, regime = "new", year = 2024, ...) {

  if(!regime %in% c("old", "new")) {
    warning("input parameter (regime) must be either 'new' or 'old' \n",
            "setting it to default: 'new' \n")
    regime <- "new"
  }

  y <- pmax(0, x - rebate_income_level_new)
  y <- pmax(0, y - rebate_standard_deduction)

  out <- structure(y,
                   tax.regime = regime, tax.year = year,
                   rebate.base.level = rebate_income_level_new,
                   rebate.standard.deduction = rebate_standard_deduction,
                   class = "ITR")
  attr(out, "tax.amount") <- tax_calculator(out)

  return(out)
}

