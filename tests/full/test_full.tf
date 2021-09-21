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

  mode = "explicit"
  groups = [{
    name     = "VPC101"
    id       = 101
    policy   = "VPC1"
    switch_1 = 101
    switch_2 = 102
  }]
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
    want        = "explicit"
  }
}

data "aci_rest" "fabricExplicitGEp" {
  dn = "${data.aci_rest.fabricProtPol.id}/expgep-VPC101"

  depends_on = [module.main]
}

resource "test_assertions" "fabricExplicitGEp" {
  component = "fabricExplicitGEp"

  equal "name" {
    description = "name"
    got         = data.aci_rest.fabricExplicitGEp.content.name
    want        = "VPC101"
  }

  equal "id" {
    description = "id"
    got         = data.aci_rest.fabricExplicitGEp.content.id
    want        = "101"
  }
}

data "aci_rest" "fabricRsVpcInstPol" {
  dn = "${data.aci_rest.fabricExplicitGEp.id}/rsvpcInstPol"

  depends_on = [module.main]
}

resource "test_assertions" "fabricRsVpcInstPol" {
  component = "fabricRsVpcInstPol"

  equal "tnVpcInstPolName" {
    description = "tnVpcInstPolName"
    got         = data.aci_rest.fabricRsVpcInstPol.content.tnVpcInstPolName
    want        = "VPC1"
  }
}

data "aci_rest" "fabricNodePEp-1" {
  dn = "${data.aci_rest.fabricExplicitGEp.id}/nodepep-101"

  depends_on = [module.main]
}

resource "test_assertions" "fabricNodePEp-1" {
  component = "fabricNodePEp-1"

  equal "id" {
    description = "id"
    got         = data.aci_rest.fabricNodePEp-1.content.id
    want        = "101"
  }
}

data "aci_rest" "fabricNodePEp-2" {
  dn = "${data.aci_rest.fabricExplicitGEp.id}/nodepep-102"

  depends_on = [module.main]
}

resource "test_assertions" "fabricNodePEp-2" {
  component = "fabricNodePEp-2"

  equal "id" {
    description = "id"
    got         = data.aci_rest.fabricNodePEp-2.content.id
    want        = "102"
  }
}