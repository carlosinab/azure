# Navigate to your repo
cd C:\path\to\your\repo  # or wherever your project is

# Initialize if not already done
git init
git remote add origin https://github.com/carlosinab/azure.git

# Add all files (respecting .gitignore)
git add .

# Check what will be committed (verify no secrets!)
git status

# Commit
git commit -m "Initial commit: Blue-green deployment setup"

# Push to main
git push -u origin main

# Create v1 and v2 branches for testing
git checkout -b v1
git push origin v1

git checkout -b v2  
git push origin v2

# Return to main
git checkout main