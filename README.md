# Sample Web Application

This is a simple web application built with HTML, CSS, and JavaScript, complemented by Docker for containerization. Below is a structured guide to help you understand and implement the project seamlessly.

---

## Project Structure
```
sample-web-app/
├── index.html           # Main HTML file
├── style.css            # CSS file for styling
├── script.js            # JavaScript file for interactivity
├── SAMPLE-WEB-APP       # Private SSH key file
├── SAMPLE-WEB-APP.pub   # Public SSH key file
```

---

## File Descriptions

### **index.html**
The core HTML file that structures the web page and links to the CSS and JavaScript files.

### **style.css**
Defines the styles and layout of the web page, ensuring a visually appealing design.

### **script.js**
Contains JavaScript logic to add interactivity, such as event handling for user actions.

### **SAMPLE-WEB-APP & SAMPLE-WEB-APP.pub**
These are SSH key files used for secure communication and authentication.
- **SAMPLE-WEB-APP**: Private SSH key (keep secure).
- **SAMPLE-WEB-APP.pub**: Public SSH key.

---

## Step-by-Step Guide

### **1. Create the Files**

#### **index.html**
Define the structure of the web page and include links to style.css and script.js:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sample Web App</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Welcome to the Sample Web App</h1>
    <button id="changeMessage">Click Me!</button>
    <p id="message">Hello, World!</p>
    <script src="script.js"></script>
</body>
</html>
```

#### **style.css**
Create basic styling for your web page:
```css
body {
    font-family: Arial, sans-serif;
    text-align: center;
    margin: 0;
    padding: 0;
    background-color: #f4f4f9;
}

h1 {
    color: #333;
}

button {
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
}

p {
    color: #555;
}
```

#### **script.js**
Add JavaScript for user interaction:
```javascript
document.getElementById('changeMessage').addEventListener('click', () => {
    document.getElementById('message').textContent = 'You clicked the button!';
});
```

---

### **2. Add SSH Key Files**
Place the `SAMPLE-WEB-APP` (private key) and `SAMPLE-WEB-APP.pub` (public key) securely in the project directory. Ensure these files are protected and not exposed publicly.

---

### **3. Create a Dockerfile**
Define a Dockerfile to containerize your application:
```dockerfile
FROM nginx:alpine
COPY . /usr/share/nginx/html
```

---

### **4. Install Docker**

#### Steps to Install Docker Desktop:
1. **Download**:
   - Visit the [Docker Desktop](https://www.docker.com/products/docker-desktop/) page.
   - Choose the version for your OS.

2. **Install**:
   - Run the installer and follow the prompts.
   - If using Windows, select "WSL 2" instead of Hyper-V during installation.

3. **Start Docker**:
   - Launch Docker Desktop from your applications menu.

4. **Verify Installation**:
   - Open a terminal and run:
     ```sh
     docker --version
     ```

---

### **5. Build and Run the Docker Container**

#### Steps:
1. Navigate to the project directory:
   ```sh
   cd /path/to/sample-web-app
   ```

2. Build the Docker image:
   ```sh
   docker build -t sample-web-app .
   ```

3. Run the container:
   ```sh
   docker run -d -p 80:80 sample-web-app
   ```

---

### **6. Bonus: Use Docker Compose for Multi-Container Setup**

#### **Create a `docker-compose.yml` File**
```yaml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "80:80"
```

#### **Start the Multi-Container Setup**
Run:
```sh
docker-compose up -d
```
This builds and runs your application in a Docker Compose environment.

---

## Security Note
Ensure sensitive files, such as `SAMPLE-WEB-APP` and `SAMPLE-WEB-APP.pub`, are not exposed to public repositories or unauthorized users. Use `.gitignore` to exclude them from version control.

```gitignore
SAMPLE-WEB-APP
SAMPLE-WEB-APP.pub
```
# Terraform Infrastructure as Code (IaC) Guide

This guide provides step-by-step instructions to deploy a VPC and an EC2 instance using Terraform modules from the Terraform Registry.

---

## **Prerequisites**

1. Install Terraform:
   - Download from the [Terraform website](https://www.terraform.io/downloads).
2. Install AWS CLI (for AWS deployments):
   - Download and configure using:
     ```bash
     aws configure
     ```
     Provide your **Access Key**, **Secret Key**, **Region**, and **Output format**.
3. Create an SSH key pair in your AWS account for accessing the EC2 instance.

---

## **Project Structure**

Create the following files in a new directory for your Terraform project:

```
terraform-iac/
├── main.tf        # Main Terraform configuration
├── variables.tf   # Input variables
├── outputs.tf     # Outputs
├── terraform.tfvars # (Optional) Variable values
```

---

## **Step 1: Initialize Terraform Project**

1. Create a directory for your project:
   ```bash
   mkdir terraform-iac
   cd terraform-iac
   ```

2. Initialize the project:
   ```bash
   terraform init
   ```

---

## **Step 2: Configure the VPC**

Use the official [Terraform AWS VPC module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws) to create a VPC, public/private subnets, NAT gateway, and associated routing.

### **`main.tf`: VPC Configuration**

```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

---

## **Step 3: Configure the EC2 Instance**

Use the [Terraform AWS EC2 Instance module](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws) to deploy an instance within the VPC.

### **`main.tf`: EC2 Configuration**

```hcl
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = "t2.micro"
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
  key_name               = "user1" 
  monitoring             = true
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0] # Use the first public subnet

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

---

## **Step 4: Define Variables**

### **`variables.tf`: Variables for Reusability**

```hcl
variable "region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Instance type for EC2"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name for the instance"
}
```

---

## **Step 5: Define Outputs**

### **`outputs.tf`**

```hcl
output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "Public subnets in the VPC"
  value       = module.vpc.public_subnets
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2_instance.public_ip
}
```

---

## **Step 6: Deploy Infrastructure**

1. Generate an execution plan:
   ```bash
   terraform plan
   ```

2. Deploy the infrastructure:
   ```bash
   terraform apply
   ```
   Confirm the deployment by typing `yes` when prompted.

---

## **Step 7: Verify Resources**

1. Log in to the AWS Management Console.
2. Verify:
   - A VPC is created with public and private subnets.
   - An EC2 instance is running in one of the public subnets.
   - The instance has a public IP address.
3. Use the following command to view outputs:
   ```bash
   terraform output
   ```

---

## **Step 8: Clean Up Resources**

To delete all resources created by Terraform, run:

```bash
terraform destroy
```

Confirm the destruction by typing `yes` when prompted.

---

## **References**
- [Terraform AWS VPC Module Documentation](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
- [Terraform AWS EC2 Instance Module Documentation](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest)

---