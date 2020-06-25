# #TerraformOnAzure Challenge - episode 3

The third challenge of the [Terraform On Azure](https://github.com/Terraform-On-Azure-Workshop/terraform-azure-hashiconf2020) requires setting up GitHub Actions to deploy the environment prepared on [Challenge 2](https://github.com/OmegaMadLab/TerraformOnAzure-Challenge2/blob/master/README.md).

We need to create a storage account to store state, and a service principal to authenticate in Terraform while calling it via GitHub Actions. 
You can read more about the challenge [here](https://github.com/Terraform-On-Azure-Workshop/terraform-azure-hashiconf2020/blob/main/challenges/challenge3/Readme.md).

I used **init.sh** to:
- create the storage account and show its keys
- create a service principal and show its credentials

Then, I saved them as environment variables in GitHub Actions, and setup a YAML pipeline to deploy the TF infrastructure.

You can find init.sh in the */setup folder*, while the YAML pipeline is in *.github/workflows/*.  