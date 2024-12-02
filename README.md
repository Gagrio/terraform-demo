##### terraform-demo

# Terraform K8s VM and GitLab Setup

This project uses Terraform to create a **libvirt** VM running **K3s** with **Podman** as the container runtime. It also installs **GitLab** using the **Helm** provider to manage the Kubernetes cluster.

## Prerequisites

Before you begin, ensure you have the following tools installed and configured:

1. **Terraform** (v1.5.0 or newer)
   - Download from: https://www.terraform.io/downloads.html

2. **Libvirt** Provider Setup
   - You need a **libvirt** environment with network and storage configured.

3. **Helm** (v3.x)
   - Install Helm from: https://helm.sh/docs/intro/install/

4. **Podman** (instead of Docker)
   - Installed via `dnf install podman` (handled by cloud-init script).

5. **SSH Key** for `george` user
   - Replace `YOUR_SSH_PUBLIC_KEY_HERE` in the `vm.tf` with your actual SSH public key.

6. **Kubernetes Cluster**
   - The project assumes you’re setting up a Kubernetes cluster using K3s on the VM.

## Project Structure

- `main.tf`: Entry point for Terraform execution. Currently contains no resources, only logical structuring.
- `providers.tf`: Contains the provider configurations for `libvirt` and `helm`.
- `vm.tf`: Contains the resources for creating the VM, including disk, network, and cloud-init configurations.
- `helm.tf`: Contains the Helm release configuration for installing GitLab.
- `variables.tf`: Default variables like Kubernetes API credentials and paths.
- `gitlab-values.yaml`: Custom values file for the GitLab Helm chart.
- `.gitlab-ci.yml`: GitLab CI configuration for automated Terraform execution.
- `terraform-pipeline.yml`: GitHub Actions pipeline configuration for Terraform execution.

## How to Use

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/k8s-vm-gitlab-terraform.git
cd k8s-vm-gitlab-terraform
```

### 2. Configure the SSH Key

- Open the `vm.tf` file.
- Replace the placeholder `YOUR_SSH_PUBLIC_KEY_HERE` with your SSH public key.

```yaml
users:
  - name: george
    ssh_authorized_keys:
      - ssh-rsa YOUR_SSH_PUBLIC_KEY_HERE
```

### 3. Initialize Terraform

Before applying any changes, you need to initialize the Terraform environment.

```bash
terraform init
```

This will download the necessary provider plugins and prepare the working directory.

### 4. Plan the Changes

To see the proposed infrastructure changes without actually applying them, run:

```bash
terraform plan
```

### 5. Apply the Changes

If everything looks good after running `terraform plan`, apply the changes to create the VM and GitLab:

```bash
terraform apply
```

You will need to manually confirm the `apply` when prompted.

### 6. GitLab Setup

After the Terraform `apply` completes, GitLab will be available on your Kubernetes cluster. You can manage it using `kubectl` or access it through the configured external IP (e.g., `10.0.0.100`).

### 7. CI/CD Pipeline (Optional)

You can automate the Terraform deployment with a CI/CD pipeline:

- **GitLab CI**: The `.gitlab-ci.yml` file defines the pipeline for automatic Terraform execution on GitLab.
  - The pipeline runs `terraform plan`, stores the plan as an artifact, and requires a manual approval to apply it.

- **GitHub Actions**: The `terraform-pipeline.yml` file defines the GitHub Actions workflow to handle Terraform execution.
  - It follows the same logic, performing `terraform plan` and `terraform apply` based on manual approval.

### 8. Terraform Variables

The default values for Kubernetes credentials are specified in the `variables.tf` file. You can override these values by creating a `terraform.tfvars` file or setting environment variables.

```hcl
k8s_host                 = "https://10.0.0.100:6443"
k8s_client_certificate   = "/etc/rancher/k3s/client-cert.pem"
k8s_client_key           = "/etc/rancher/k3s/client-key.pem"
k8s_cluster_ca_certificate = "/etc/rancher/k3s/ca.pem"
```

## Troubleshooting

- **SSH Issues**: Ensure that the SSH key provided in `vm.tf` is correct and accessible.
- **Helm Deployment Issues**: If GitLab fails to deploy, check the Helm logs for detailed error messages.
- **Libvirt Connectivity**: Ensure your libvirt setup has the necessary resources (network, storage pool) and that the VM is correctly configured.

## Contributing

Feel free to submit issues and pull requests to improve the project. Contributions are welcome!

## License

This project is licensed under the MIT License.
