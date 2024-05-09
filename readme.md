# Terraform Projects Templates

  These templates are designed to help you kickstart your infrastructure as code journey with Terraform on AWS. Whether you're a beginner or an experienced user, you'll find these templates useful for creating, managing, and scaling your infrastructure.

## Project List


### 1. Terraform Instance Creation
Use this template to quickly provision EC2 instances on AWS. It includes configurations for instance types, AMIs, security groups, and more. Ideal for creating VM instances tailored to your application needs.

### 2. Terraform Modules
Modularization is key to maintaining clean and reusable infrastructure code. This template demonstrates how to structure your Terraform code into modules, allowing you to encapsulate and reuse infrastructure components across projects.

### 3. Terraform Backend
Setting up Terraform's backend correctly is crucial for managing state files securely and efficiently. This template provides configurations for various backend options like S3 and DynamoDB, ensuring your Terraform workflow is smooth and reliable.

### 4. AWS Architecture (terraform)
This template provides a comprehensive AWS architecture setup, including VPC, subnets, security groups, and more. It's a great starting point for building robust and scalable infrastructures on AWS.


Will be adding some more to this list !

Each project template comes with its own README file providing detailed instructions on how to use and customize it for your needs. Below is a general guide on how to get started:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/Terraform-templates.git
   cd Terraform-templates
    ```
2. **Choose a Template**:
Navigate to the template directory you want to use, e.g., cd Aws-Architecture.
3. **Customize Configuration**:
Modify the variables.tf and main.tf files to match your specific requirements like ami's, region, name, etc.
And yep you are good to go.

4. **Hit the terraform commands init, plan, apply.** 

Note: Don't forget to destroy the resources after testing.