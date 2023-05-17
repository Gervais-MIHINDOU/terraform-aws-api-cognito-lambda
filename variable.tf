variable "path_part" {
  type = string
  description = "Nom du chemin de la ressource"
}
variable "http_method" {
  type = string
  description = "Methode utiliser"
}
variable "stage_name" {
  type = string
  description = "nom de lénvironnemnt"
}
variable "function_name" {
  type = string
  description = "nom de la fonction"
}
variable "is_api" {
  description = "Donne l info si on a besoin d une api pour la lambda que l on cree"
  type = bool
  default = true
}

variable "variables_environement" {
  type = any
  description = "La liste des variables d environment de la lambda"
}