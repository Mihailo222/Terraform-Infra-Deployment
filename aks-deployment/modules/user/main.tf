# create user module for AKS cluster

resource "azuread_user" "user" {
    user_principal_name = "clusterUser@@mahovacmihailogmail.onmicrosoft.com"
    display_name = "Cluster User I"
    password = random_password.rand_pass.results
    mail_nickname = "clustas"
}

resource "random_password" "rand_pass" {
    length  = 16
    special = true
    override_special = "!@#$%^&*()_+"
}