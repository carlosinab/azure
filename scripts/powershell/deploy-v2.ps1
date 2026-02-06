# Push to v2 branch
git checkout -b v2
git add .
git commit -m "Deploy v2"
git push origin v2

# Run workflow: version=v2, action=deploy-to-staging (deploys to staging slot)
# Verify staging slot shows green
# Run workflow: version=v2, action=swap-production (swaps to production)