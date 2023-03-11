utils:::globalVariables(c("data.taxslabs"))

#' tax slabs with updated tax rate FY 2022-23 (AY 2023-24) under old regime
#' @export
#'
data.taxslabs

#' @rdname tax_calculator
#' @description calculates tax based on the income slab
#' @param x annual income
#' @param tax.regime new or old
#' @param tax.year financial year
#'
#' @examples
#' x <- tax_payable(2500000)
#' tax_calculator(x)
#' tax_calculator(x, tax.regime = "old")
#' tax_calculator(x, tax.regime = NA, tax.year = 2022)
#' tax_calculator(2500000)
#' tax_calculator(2500000, tax.regime = "new", tax.year = 2024)
#' tax_calculator(2500000, tax.regime = "old", tax.year = 2024)
#'
tax_calculator <- function(x, tax.regime = attr(x, "tax.regime"),
                           tax.year = attr(x, "tax.year")) {

  if(is.null(tax.regime) || !tax.regime %in% c("new", "old")) {
    warning("Either input class is not proper or \n",
            "input parameter (tax.regime) is not either 'new' or 'old' \n",
            "setting it to default: 'new' \n")
    tax.regime <- "new"
  }

  if(is.null(tax.year) || !tax.year %in% c(2024)) {
    warning("Either input class is not proper or \n",
            "input parameter (tax.year) is not available \n",
            "setting it to default: 2024 \n")
    tax.year <- 2024
  }

  sum(do.call(c, lapply(switch(tax.regime, new = 2:6, old = 2:4), function(id)
    make_slab_adjustments(x, id, regime = tax.regime, year = tax.year))))
}

#' @rdname tax_calculator
#' @description function to calculate tax between slabs
#' @param x amount
#' @param id id from tax slab data (old/new)
#' @param tax.regime new or old
#' @param tax.year financial year
#'
#' @examples
#' make_slab_adjustments(x = 2500000, id = 1)
#'
#' d <- subset(data.taxslabs, taxslab.regime == "old", taxslab.year = 2024)
#' names(d) <- gsub("taxslab.", "", names(d))
#' make_slab_adjustments(d, x = 2500000, id = 2)
#'
make_slab_adjustments <- function(x, id = 2, regime = "new", year = 2024) {

  dd <- subset(data.taxslabs, taxslab.regime == regime, year = tax.year)
  names(dd) <- gsub("taxslab.", "", names(dd))

  if(!length(id) == 1 || !id %in% dd$id)
    stop("input parameter (id) is not available for \n",
         "tax.regime = ", regime, " & tax.year = ", year)

  slab_flag <- dd$id == id
  slab_tax <- dd$max[slab_flag] - dd$min[slab_flag]

  ifelse(
    is.na(dd$max[slab_flag]),
    pmax(0, x - dd$min[slab_flag]) * dd$percent[slab_flag],
    pmin(pmax(0, x - dd$min[slab_flag]),
         dd$max[slab_flag] - dd$min[slab_flag]) * dd$percent[slab_flag])
  }



