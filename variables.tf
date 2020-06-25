variable "location" {
    description = "Azure region"
    default = "westeurope"
}

variable "envprefix" {
    description = "Used to compose the final name of the resources"
    default = "tfonazure-challenge3-"
}

variable "dbuid" {
    description = "Username for mongo and SQL Server dbs"
    default = "omegamadlab"
}

variable "dbpassword" {
    description = "Password for mongo and SQL Server dbs"
}

variable "repourl" {
    description = "Url of the Git Repo used for CI"
    default = "https://github.com/OmegaMadLab/AzureEats-Website"
}