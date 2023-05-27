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
variable "variables_environement" {
  type = map(string)
  description = "La liste des variables d environment de la lambda"
  default = {}
}
variable "runtime" {
  type = string
  description = "language utiliser"
}