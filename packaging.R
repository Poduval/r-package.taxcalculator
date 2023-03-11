library(devtools)
library(openxlsx)

use_build_ignore(c('packaging.R', 'release', "materials"))

data.taxslabs <- read.xlsx("materials/data.xlsx", sheet = "tax-slabs")
use_data(data.taxslabs, overwrite = TRUE)

document()
check(quiet = FALSE)
build(path = "release/", quiet = FALSE, binary = FALSE)
install(upgrade_dependencies = F)


if (FALSE) {
  # RUN IN A FRESH SESSION
  library(taxcalculator)
  taxCalculator(400000)
}
