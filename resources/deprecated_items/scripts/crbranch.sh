#!/bin/bash

# Update local repo
git fetch origin main
git pull origin main

# Ask for branch name
echo "Enter branch name:"
read branchName

# Create and checkout the new branch
git checkout -b $branchName

# Publish branch to GitLab
git push origin $branchName

# Notify user that changes have been sent to GitLab
echo "You are on $branchName, and it has been published to GitHub :)"
echo "Type 'git status' to see your current changes."
echo "Once you are done, you can run ./gitsend.sh to publish your changes to GitHub."
