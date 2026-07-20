terraform {

  cloud {
    
    organization = "hakym-dev-project"

    workspaces {
      name = "terraform-playground"
    }
  }
}