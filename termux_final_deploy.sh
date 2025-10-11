#!/bin/bash
set -e
echo "🔄 Starting FINAL Deployment..."
# 1️⃣ Ensure we are in the project directory
cd "$HOME/pea-2025"

echo "🛠️ Finalizing stable build configuration..."
# Ensure all dependencies are present and stable (this is fast if they exist)
npm install react-scripts react@17.0.2 react-dom@17.0.2 --force >/dev/null 2>&1

# 2️⃣ Run the stable build
echo "🏗️ Running stable build (Configuration is NOW set)..."
if ! npm run build ; then
    echo "🛑 BUILD FAILED. Check for JavaScript or dependency errors."
    exit 1
fi

# 3️⃣ Deploy
echo "📦 Renaming build folder..."
rm -rf dist 2>/dev/null || true
mv build dist
echo "🚢 Deploying to GitHub Pages..."
npm run deploy >/dev/null 2>&1

# 4️⃣ Done
echo "✅ Deployment complete! Site should now be updated."
echo "---------------------------------------------------------"
echo "🌐 Site updated at: https://jabathykini-hub.github.io/PEA2025/"
echo "---------------------------------------------------------"
