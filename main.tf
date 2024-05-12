module "network" {
  source = "./modules/network"

}

module "security" {
  depends_on = [module.network]
  source     = "./modules/security"
  vpc_id     = module.network.vpc_id

}

module "auth" {
  depends_on = [module.network, module.security]
  source     = "./modules/auth"

}

module "compute" {
  source = "./modules/compute"

  depends_on = [module.network, module.auth]
  subnet_id  = module.network.subnet_id
  sg_id      = module.security.sg_id
  key_name   = module.auth.key_name
  key_priv   = module.auth.ssh-private-key
  key_pub    = module.auth.ssh-public-key
}

