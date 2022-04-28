terraform {
  cloud {
    organization = "globomantics-mjd"

    workspaces {
      name = "diamonddogs-app-useast1-dev"
    }
  }
}