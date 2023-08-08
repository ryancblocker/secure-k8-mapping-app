#!/bin/bash

# Get current branch name
branch=$(git rev-parse --abbrev-ref HEAD)

# Push current branch to gitlab
git fetch origin main
git pull origin main
git push -f origin $branch

#Stage all changes from the directory above the one im in
cd ../..
git add .

# Commit changes and prompt user for commit message
echo "Enter commit message: "
read commitMessage
git commit -m "$commitMessage"

#push changes to gitlab
git push origin $branch

# Notify user that changes have been sent to gitlab
echo "Changes sent to GitHub successfully :)"
