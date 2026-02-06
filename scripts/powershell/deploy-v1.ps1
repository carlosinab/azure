# Push to v1 branch
git checkout -b v1
git add .
git commit -m "Deploy v1"
git push origin v1

# Go to GitHub Actions → Run workflow manually with version=v1, action=deploy-to-staging
# Then run workflow with action=swap-production