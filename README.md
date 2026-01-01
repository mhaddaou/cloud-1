# Cloud-1

**Automated Deployment of Inception on Cloud Infrastructure**

This project automates the deployment of a complete WordPress infrastructure (Inception project) on a cloud-hosted server using Infrastructure as Code (IaC) with Terraform. The deployment provisions a DigitalOcean droplet and automatically sets up Docker containers for WordPress, MariaDB, and related services.

## Project Overview

Cloud-1 is designed to deploy your Inception project on real cloud infrastructure with full automation. Unlike the local Inception setup, this project:

- Provisions cloud servers automatically using Terraform
- Deploys containerized services (1 process = 1 container)
- Ensures data persistence across reboots
- Implements automated deployment workflows
- Uses real cloud resources with cost management considerations

## Architecture

The infrastructure consists of:

- **Cloud Provider**: DigitalOcean
- **Droplet Size**: 2 vCPUs, 2GB RAM (`s-2vcpu-2gb`)
- **Operating System**: Ubuntu 22.04 LTS
- **Orchestration**: Docker & Docker Compose
- **Automation**: Terraform + Shell Scripts

### Services Deployed

- **WordPress**: Main web application
- **MariaDB**: Database backend
- **Nginx**: Web server and reverse proxy
- **PHPMyAdmin**: Database management interface

Each service runs in its own Docker container following the "1 process = 1 container" principle.

## Prerequisites

Before starting, ensure you have:

- [Terraform](https://www.terraform.io/downloads.html) v1.0+ installed
- A [DigitalOcean account](https://www.digitalocean.com/)
- DigitalOcean API token ([create here](https://cloud.digitalocean.com/account/api/tokens))
- SSH key added to your DigitalOcean account
- Basic understanding of Docker and cloud infrastructure

## Project Structure

```
.
├── main.tf                  # Main Terraform configuration
├── variables.tf             # Variable definitions
├── terraform.tfvars         # Your credentials (DO NOT COMMIT)
├── terraform.tfvars.example # Template for credentials
├── setup.sh                 # Automated droplet initialization script
├── .gitignore              # Protects sensitive files
└── README.md               # This file
```

## Quick Start Guide

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd cloud-1
```

### 2. Configure Your Credentials

Create `terraform.tfvars` from the example:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your actual values:

```hcl
do_token      = "dop_v1_YOUR_ACTUAL_DIGITALOCEAN_API_TOKEN"
ssh_key_name  = "your-ssh-key-name"
region        = "fra1"
droplet_name  = "cloud-1-inception"
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Preview Changes

```bash
terraform plan
```

### 5. Deploy Infrastructure

```bash
terraform apply
```

Type `yes` when prompted. Terraform will:
1. Create the droplet on DigitalOcean
2. Configure SSH access
3. Run the setup script automatically
4. Install Docker and Docker Compose
5. Clone and deploy your Inception project

### 6. Access Your Droplet

After deployment completes, get the IP address:

```bash
terraform output droplet_ip
```

Connect via SSH:

```bash
ssh root@<droplet_ip>
```

## Configuration Variables

| Variable | Description | Type | Default | Required |
|----------|-------------|------|---------|----------|
| `do_token` | DigitalOcean API Token | string | - | **Yes** |
| `ssh_key_name` | SSH key name in DigitalOcean | string | `"my-ssh-key"` | No |
| `region` | DigitalOcean region | string | `"fra1"` | No |
| `droplet_name` | Name for the droplet | string | `"future-Billionaires"` | No |

### Available Regions

- `fra1` - Frankfurt, Germany
- `nyc1`, `nyc3` - New York, USA
- `sfo3` - San Francisco, USA
- `lon1` - London, UK
- `ams3` - Amsterdam, Netherlands
- `sgp1` - Singapore

[Complete region list](https://docs.digitalocean.com/products/platform/availability-matrix/)

## What Gets Installed

The `setup.sh` script automatically:

1. Updates the system packages
2. Installs Docker and Docker Compose
3. Installs Git and Make
4. Creates Docker group and enables the service
5. Creates necessary data directories for volume persistence:
   - `/home/asalek/data/maria_v` (MariaDB data)
   - `/home/asalek/data/wordpress_v` (WordPress data)
6. Clones your Inception project from GitHub
7. Runs `make` to build and start all containers

## Security Best Practices

### Critical Security Notes

⚠️ **NEVER commit your `terraform.tfvars` file** - it contains your API token!

⚠️ **Monitor your cloud costs** - you are responsible for charges!

⚠️ **Destroy resources when done** - avoid unnecessary billing!

### Protecting Your Credentials

The `.gitignore` file automatically prevents committing:
- `terraform.tfvars` (your credentials)
- `*.tfstate` files (contain sensitive data)
- SSH keys
- Terraform lock files

### Alternative: Environment Variables

Instead of `terraform.tfvars`, use environment variables:

```bash
export TF_VAR_do_token="your-token-here"
export TF_VAR_ssh_key_name="your-ssh-key"
terraform apply
```

### SSH Key Management

1. Generate an SSH key if you don't have one:
   ```bash
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. Add it to DigitalOcean:
   - Go to [DigitalOcean Security Settings](https://cloud.digitalocean.com/account/security)
   - Click "Add SSH Key"
   - Paste your public key (`~/.ssh/id_ed25519.pub`)

## Project Requirements Compliance

This project fulfills the Cloud-1 subject requirements:

- ✅ **Fully automated deployment** using Terraform
- ✅ **Automatic restart** on server reboot (systemd enables Docker)
- ✅ **Data persistence** via Docker volumes in `/home/asalek/data/`
- ✅ **Scalable deployment** - can deploy to multiple servers
- ✅ **Ubuntu 22.04 LTS** base system
- ✅ **Separate containers** for each process
- ✅ **docker-compose.yml** for service orchestration
- ✅ **WordPress + MariaDB + PHPMyAdmin** stack
- ✅ **Secure database access** (not publicly exposed)

## Useful Commands

### View Infrastructure State

```bash
terraform show
```

### Destroy All Resources

```bash
terraform destroy
```

**WARNING**: This will permanently delete your droplet and all data!

### Format Terraform Files

```bash
terraform fmt
```

### Validate Configuration

```bash
terraform validate
```

### View Outputs

```bash
terraform output
terraform output droplet_ip
```

### Check Droplet Status

```bash
ssh root@<droplet_ip> "docker ps"
```

## Cost Management

### Current Configuration Cost

Droplet size `s-2vcpu-2gb`:
- **Hourly**: ~$0.027/hour
- **Monthly**: ~$18/month

[Check current pricing](https://www.digitalocean.com/pricing/droplets)

### Cost Optimization Tips

1. **Use free credits**: Take advantage of student credits (GitHub Education, DigitalOcean)
2. **Destroy when not in use**: Run `terraform destroy` when done testing
3. **Monitor usage**: Check DigitalOcean dashboard regularly
4. **Set billing alerts**: Configure alerts in DigitalOcean settings
5. **Right-size resources**: Don't over-provision CPU/RAM

⚠️ **IMPORTANT**: You are responsible for all cloud costs. Monitor your spending!

## Customization

### Change Droplet Size

Edit [main.tf](main.tf#L23):

```hcl
size = "s-1vcpu-1gb"    # Smaller (cheaper)
size = "s-4vcpu-8gb"    # Larger (more expensive)
```

[View all available sizes](https://slugs.do-api.dev/)

### Change Operating System

Edit [main.tf](main.tf#L24):

```hcl
image = "ubuntu-24-04-x64"
image = "debian-12-x64"
```

### Modify Setup Script

Customize [setup.sh](setup.sh) to:
- Install additional packages
- Configure different services
- Clone a different repository
- Add custom initialization steps

### Deploy to Multiple Servers

Terraform makes it easy to deploy to multiple servers:

```bash
# Deploy to production
terraform apply -var="droplet_name=production-server"

# Deploy to staging
terraform apply -var="droplet_name=staging-server"
```

## Troubleshooting

### SSH Key Not Found Error

**Error**: `Error: ssh key not found`

**Solution**:
1. List your SSH keys:
   ```bash
   doctl compute ssh-key list
   ```
2. Update `ssh_key_name` in `terraform.tfvars`

### Authentication Error (401)

**Error**: `Error: GET https://api.digitalocean.com/v2/account: 401`

**Solution**:
- Verify your API token is correct
- Check token hasn't expired
- Ensure token has read/write permissions

### Setup Script Fails

**Error**: Droplet created but setup fails

**Solution**:
1. SSH into the droplet
2. Check cloud-init logs:
   ```bash
   cat /var/log/cloud-init-output.log
   ```
3. Manually run the setup script:
   ```bash
   bash /var/lib/cloud/instance/scripts/part-001
   ```

### Docker Containers Not Running

**Solution**:
```bash
ssh root@<droplet_ip>
cd /root/cloud_1
docker-compose ps
docker-compose logs
```

### Port 80/443 Not Accessible

**Solution**:
- Check DigitalOcean firewall rules
- Verify Nginx is running: `docker ps`
- Check container logs: `docker logs <container_name>`

## Development Workflow

### Testing Changes

1. Make changes to Terraform files
2. Format code: `terraform fmt`
3. Validate: `terraform validate`
4. Preview: `terraform plan`
5. Apply: `terraform apply`

### Incremental Updates

Terraform tracks state, so you can make incremental changes:

```bash
# Modify variables.tf or main.tf
terraform plan   # See what will change
terraform apply  # Apply only the changes
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -m 'Add improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

## Important Warnings

⚠️ **Real Cloud Resources**: This project uses real cloud infrastructure with real costs

⚠️ **Your Responsibility**: You are responsible for:
- Managing and stopping deployed resources
- Monitoring costs and usage
- Securing credentials and API tokens
- Complying with cloud provider terms of service

⚠️ **No School Support**: The school cannot help with cloud provider billing or account issues

⚠️ **GitHub Security**: Never commit API tokens, credentials, or sensitive data to public repositories

## Resources

### Official Documentation

- [Terraform Documentation](https://www.terraform.io/docs)
- [DigitalOcean API Docs](https://docs.digitalocean.com/reference/api/)
- [DigitalOcean Terraform Provider](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs)
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

### Free Credits & Student Programs

- [GitHub Student Developer Pack](https://education.github.com/pack) - Includes DigitalOcean credits
- [DigitalOcean for Students](https://www.digitalocean.com/github-students)
- [AWS Educate](https://aws.amazon.com/education/awseducate/)
- [Google Cloud for Students](https://cloud.google.com/edu/students)
- [Microsoft Azure for Students](https://azure.microsoft.com/en-us/free/students/)

### Additional Resources

- [Inception Project Reference](https://github.com/Asalek/cloud_1)
- [Free Domain Names - DuckDNS](https://www.duckdns.org/)
- [Let's Encrypt - Free SSL](https://letsencrypt.org/)

## License

This project is open source and available under the [MIT License](LICENSE).

## Author

Built as part of the 42 School Cloud-1 curriculum.

## Acknowledgments

- Subject by Rémy Léone (rleone@scaleway.com)
- Based on the Inception project requirements
- Uses DigitalOcean infrastructure
- Powered by Terraform and Docker
