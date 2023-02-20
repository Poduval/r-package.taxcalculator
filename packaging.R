library(devtools)

use_build_ignore(c('packaging.R', 'release'))
document()
check(quiet = FALSE)
build(path = "release/", quiet = FALSE, binary = FALSE)
install(upgrade_dependencies = F)


if (FALSE) {
  # RUN IN A FRESH SESSION
  library(taxcalculator)
  taxCalculator(400000)
}
