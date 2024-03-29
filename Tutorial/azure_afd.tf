terraform {


}

resource "azurerm_resource_group" "afd_example_rg" {
  name     = "FrontDoorExampleResourceGroup"
  location = "West Europe"
}

resource "azurerm_frontdoor" "afd_example_afd" {
  name                                         = "example-FrontDoor-ckw"
  resource_group_name                          = azurerm_resource_group.afd_example_rg.name
  enforce_backend_pools_certificate_name_check = true

  routing_rule {
    name               = "exampleRoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["example-FrontDoor-ckw"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "exampleBackendBing"
    }
  }

  backend_pool_load_balancing {
    name = "exampleLoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "exampleHealthProbeSetting1"
  }

  backend_pool {
    name = "exampleBackendBing"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "exampleLoadBalancingSettings1"
    health_probe_name   = "exampleHealthProbeSetting1"
  }

  frontend_endpoint {
    name      = "example-FrontDoor-ckw"
    host_name = "example-FrontDoor-ckw.azurefd.net"
  }
}