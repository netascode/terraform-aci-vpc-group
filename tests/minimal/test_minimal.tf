terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  mode = "consecutive"
}

data "aci_rest" "fabricProtPol" {
  dn = "uni/fabric/protpol"

  depends_on = [module.main]
}

resource "test_assertions" "fabricProtPol" {
  component = "fabricProtPol"

  equal "pairT" {
    description = "pairT"
    got         = data.aci_rest.fabricProtPol.content.pairT
    want        = "consecutive"
  }
}
