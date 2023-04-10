Task 7 - issues covered:
- understanding the principle of CI/CD 
- creating CI/CD pipeline using Terraform and Github actions
- creating service account and generating private key for terraform access
- creating a pipeline running every time a new commit is pushed to main branch in the repository
- creating a pipeline including steps like stting up the job, trigger defined, terraform actions (setup, init, format, plan, apply) and verification
- best practices using Terraform

Task 8 was pushed to different repository - dareit-terraform:
name: 'Terraform CI'

on:
  push:
    branches:
    - main

jobs:
  terraform:
    name: 'Terraform'
    runs-on: ubuntu-latest

    # Use the Bash shell regardless whether the GitHub Actions runner is ubuntu-latest, macos-latest, or windows-latest
    defaults:
      run:
        shell: bash

    steps:
    # Checkout the repository to the GitHub Actions runner
    - name: Checkout
      uses: actions/checkout@v2

    # Install the latest version of Terraform CLI
    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v1


    # Initialize a new or existing Terraform working directory by creating initial files, loading any remote state, downloading modules, etc.
    - name: Terraform Init
      run: terraform init
      env:
        GOOGLE_CREDENTIALS: ${{ secrets.TF_GOOGLE_CREDENTIALS }}

    # Run terraform fmt to check whether the formatting of the files is correct
    - name: Terraform Format
      run: terraform fmt -check

    # Run terraform plan
    - name: Terraform Plan
      run: terraform plan
      env:
        GOOGLE_CREDENTIALS: ${{ secrets.TF_GOOGLE_CREDENTIALS }}

    # Run terraform apply
    - name: Terraform Apply
      run: terraform apply -auto-approve
      env:
        GOOGLE_CREDENTIALS: ${{ secrets.TF_GOOGLE_CREDENTIALS }}
