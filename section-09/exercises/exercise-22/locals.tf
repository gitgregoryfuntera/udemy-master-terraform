locals {
  numbers_list = var.numbers_list
  object_list  = var.object_list
  double_numbers = [for f in var.numbers_list :
    f * 2
  ]
  even_numbers = [for f in var.numbers_list : f if f % 2 == 0]
  firstnames   = [for f in var.object_list : f.firstname]
  fullnames    = [for f in var.object_list : "${f.firstname} ${f.lastname}"]
}
