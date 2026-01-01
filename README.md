# DigitalOcean Droplet Terraform Setup

Automated infrastructure provisioning for DigitalOcean droplets using Terraform. This project creates a configured Ubuntu 22.04 droplet with Docker, Docker Compose, and automated application deployment.

## Features

- **Automated Droplet Provisioning**: Creates a DigitalOcean droplet with 2 vCPUs and 2GB RAM
- **Pre-configured Environment**: Automatically installs Docker, Docker Compose, Git, and Make
- **SSH Key Integration**: Uses existing DigitalOcean SSH keys for secure access
- **Custom Initialization**: Runs automated setup scripts on first boot
- **Infrastructure as Code**: Fully reproducible infrastructure deployment

## Prerequisites

Before you begin, ensure you have the following:

- [Terraform](https://www.terraform.io/downloads.html) installed (v1.0+)
- A [DigitalOcean account](https://www.digitalocean.com/)
- DigitalOcean API token ([create one here](https://cloud.digitalocean.com/account/api/tokens))
- SSH key added to your DigitalOcean account

## Project Structure

```
.
├── main.tf              # Main Terraform configuration
├── variables.tf         # Variable definitions
├── terraform.tfvars     # Variable values (DO NOT commit this file)
├── setup.sh            # Droplet initialization script
└── README.md           # This file
```

## Quick Start

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd <your-repo-name>
```

### 2. Configure Variables

Create a `terraform.tfvars` file from the example:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your values:

```hcl
do_token      = "your-digitalocean-api-token"
ssh_key_name  = "your-ssh-key-name"
region        = "fra1"
droplet_name  = "my-droplet"
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the Plan

```bash
terraform plan
```

### 5. Apply the Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

### 6. Get Droplet Information

After successful deployment, Terraform will output:

```
droplet_ip     = "xxx.xxx.xxx.xxx"
droplet_status = "active"
```

### 7. Connect to Your Droplet

```bash
ssh root@<droplet_ip>
```

## Configuration Variables

| Variable | Description | Type | Default | Required |
|----------|-------------|------|---------|----------|
| `do_token` | DigitalOcean API Token | string | - | Yes |
| `ssh_key_name` | Name of SSH key in DigitalOcean | string | `"my-ssh-key"` | No |
| `region` | DigitalOcean region | string | `"fra1"` | No |
| `droplet_name` | Name of the droplet | string | `"future-Billionaires"` | No |

### Available Regions

Common DigitalOcean regions:
- `fra1` - Frankfurt, Germany
- `nyc1`, `nyc3` - New York, USA
- `sfo3` - San Francisco, USA
- `lon1` - London, UK
- `ams3` - Amsterdam, Netherlands
- `sgp1` - Singapore

[Full list of regions](https://docs.digitalocean.com/products/platform/availability-matrix/)

## What Gets Installed

The `setup.sh` script automatically configures the droplet with:

- **System Updates**: Latest package updates
- **Docker Engine**: Container runtime
- **Docker Compose**: Multi-container orchestration
- **Git**: Version control
- **Make**: Build automation
- **Custom Application**: Clones and runs your project from GitHub

## Security Best Practices

### Important: Protect Your Credentials

1. **Never commit `terraform.tfvars`** containing your API token
2. Add to `.gitignore`:
   ```
   terraform.tfvars
   *.tfstate
   *.tfstate.backup
   .terraform/
   ```

3. Use environment variables as an alternative:
   ```bash
   export TF_VAR_do_token="your-token-here"
   terraform apply
   ```

4. Rotate your API tokens regularly
5. Use SSH keys instead of password authentication
6. Enable DigitalOcean firewall rules

## Useful Commands

### View Current State

```bash
terraform show
```

### Destroy Infrastructure

```bash
terraform destroy
```

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
```

## Troubleshooting

### SSH Key Not Found

If you get an error about SSH key not found:

1. List your SSH keys in DigitalOcean:
   ```bash
   doctl compute ssh-key list
   ```
2. Update `ssh_key_name` in `terraform.tfvars` with the correct name

### Authentication Error

If you get a 401 authentication error:
- Verify your API token is correct
- Check token permissions in DigitalOcean dashboard
- Ensure token hasn't expired

### Setup Script Fails

If the initialization script fails:
1. SSH into the droplet
2. Check logs: `cat /var/log/cloud-init-output.log`
3. Manually run: `bash /var/lib/cloud/instance/scripts/part-001`

## Customization

### Modify Droplet Size

Edit [main.tf](main.tf#L23) to change the droplet size:

```hcl
size = "s-1vcpu-1gb"  # Smaller
size = "s-4vcpu-8gb"  # Larger
```

[View all available sizes](https://slugs.do-api.dev/)

### Change Operating System

Edit [main.tf](main.tf#L24) to use a different image:

```hcl
image = "ubuntu-24-04-x64"
image = "debian-12-x64"
```

### Customize Setup Script

Modify [setup.sh](setup.sh) to add your own initialization commands.

## Cost Estimation

Current configuration (`s-2vcpu-2gb`):
- **Hourly**: ~$0.027/hour
- **Monthly**: ~$18/month

Check current pricing: [DigitalOcean Pricing](https://www.digitalocean.com/pricing/droplets)

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is open source and available under the [MIT License](LICENSE).

## Support

For issues and questions:
- Open an issue in this repository
- Check [DigitalOcean Documentation](https://docs.digitalocean.com/)
- Review [Terraform Documentation](https://www.terraform.io/docs)

## Acknowledgments

- Built with [Terraform](https://www.terraform.io/)
- Hosted on [DigitalOcean](https://www.digitalocean.com/)
- Uses the [DigitalOcean Terraform Provider](https://registry.terraform.io/providers/digitalocean/digitalocean/latest)
