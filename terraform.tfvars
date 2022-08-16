plan_os_type  = "Linux"
plan_sku      = "F1"
sub_id        = "d227de07-9426-416c-b112-49233e369b61"
vnet_location = "eastus"
nsg_location  = "eastus"

app_list = {
  "hrm-admin" = {
    location                = "eastus",
    https_only              = true,
    client_affinity_enabled = true,
    site_always_on          = false,
    application_stack = {
      docker_image     = "azureadmin.azurecr.io/admin"
      docker_image_tag = "latest"
    },
    env_variables = {
      DOCKER_REGISTRY_SERVER_PASSWORD = "COY8ZnO=FYKPBq3GeDY2YsyHfOajEUXd",
      DOCKER_REGISTRY_SERVER_URL      = "https://azureadmin.azurecr.io",
      DOCKER_REGISTRY_SERVER_USERNAME = "AzureAdmin"
    }
  }

  "hrm-communication" = {
    location                = "eastus",
    https_only              = true,
    client_affinity_enabled = true,
    site_always_on          = false,
    application_stack = {
      docker_image     = "azureadmin.azurecr.io/admin"
      docker_image_tag = "latest"
    },
    env_variables = {
      DOCKER_REGISTRY_SERVER_PASSWORD = "COY8ZnO=FYKPBq3GeDY2YsyHfOajEUXd",
      DOCKER_REGISTRY_SERVER_URL      = "https://azureadmin.azurecr.io/admin",
      DOCKER_REGISTRY_SERVER_USERNAME = "AzureAdmin"
    }
  }

  "hrm-employee" = {
    location                = "eastus",
    https_only              = true,
    client_affinity_enabled = true,
    site_always_on          = false,
    application_stack = {
      dotnet_version = "6.0"
    },
    env_variables = {}
  }

  "hrm-gateway" = {
    location                = "eastus",
    https_only              = true,
    client_affinity_enabled = true,
    site_always_on          = false,
    application_stack = {
      dotnet_version = "6.0"
    }
    env_variables = {}
  }
}

db_list = [
  {
    service_name = "admin"
    charset      = "UTF8"
    collation    = "English_United States.1252"
  },
  {
    service_name = "communication"
    charset      = "UTF8"
    collation    = "English_United States.1252"
  }
]

subnet_list = {
  "web-app-private" = {
    address_prefixes = ["10.0.1.0/24"]
  }

  "db" = {
    address_prefixes = ["10.0.2.0/24"]
  }

  "service-bus" = {
    address_prefixes = ["10.0.3.0/24"]
  }
}

security_rules = [
  {
    name                       = "Database"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "SPA"
    priority                   = 3000
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

db_other_specs = {
  storage_mb = "5120"
  backup_retention_days        = "7"
  geo_redundant_backup_enabled = "false"
  auto_grow_enabled            = "true"
  ssl_enforcement_enabled      = "true"
}