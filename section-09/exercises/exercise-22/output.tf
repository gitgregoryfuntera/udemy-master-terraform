output "show_output" {
  value = {
    numbers        = local.numbers_list
    double_numbers = local.double_numbers
    even_numbers   = local.even_numbers
    firstnames     = local.firstnames
    fullnames      = local.fullnames
  }
}
