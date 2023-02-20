#' tax calculator
#' @description Calculation of tax amount in India
#'
#' @param x annual income
#' @param sec_80c investment declaration under section 80C
#' @param standard_deduction constant, could change over time though
#' @param no_tax_bracket non taxable bracket, could change over time though.
#'
#' @examples
#' taxCalculator(300000)
#' taxCalculator(600000)
#' taxCalculator(1000000)
#' taxCalculator(2000000, sec_80c = 120000)
#'
#' @export
#'
taxCalculator <- function(x,
                          sec_80c = 0,
                          standard_deduction = 50000,
                          no_tax_bracket = 250000) {

  # some rules
  sec_80c_limit <- 150000

  # calculate taxable amount after deductions
  sec_80c_adjusted <- pmin(sec_80c_limit, pmax(0, sec_80c))
  taxable_income <- x - no_tax_bracket - standard_deduction - sec_80c_adjusted
  taxable_income <- pmax(0, taxable_income)

  if (!taxable_income > 0) {
    cat("you do not fall under taxable bucket", "\n")
    return(0)
  }

  options(scipen = 999)
  cat("your taxable amount is :", format(taxable_income, big.mark = "'"), "\n")

  tax_bracket_1 <- pmax(0, taxable_income - 250000)
  tax_bracket_2 <- pmax(0, taxable_income - 500000)
  tax_bracket_3 <- pmax(0, taxable_income - 750000)
  tax_bracket_4 <- pmax(0, taxable_income - 1000000)
  tax_bracket_5 <- pmax(0, taxable_income - 1500000)

  taxable_amount <- tax_bracket_1 * 0.05 + tax_bracket_2 * 0.10 +
    tax_bracket_3 * 0.15 + tax_bracket_4 * 0.20 +
    tax_bracket_5 * 0.30

  cat("Total payable tax amount : ", format(taxable_amount, big.mark = "'"), "\n")
  cat("\n")
  cat("Tax components in detail: \n")

  list(
    taxable_amount = taxable_amount,
    investment_under_80c = sec_80c_adjusted,
    standard_deduction = standard_deduction)
}
