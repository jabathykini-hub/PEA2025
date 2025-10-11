#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

echo "🔄 Starting Next.js to Stable React Build Conversion..."

# 1️⃣ Navigate to Project Directory
if [ -d "$HOME/pea-2025" ]; then
    cd "$HOME/pea-2025"
    echo "📁 Entered project directory: $(pwd)"
else
    echo "🛑 Error: Project directory ~/pea-2025 not found. Exiting."
    exit 1
fi

# 2️⃣ Install Stable Dependencies
echo "➕ Installing Create React App (CRA) dependencies for stable build..."
# Install react-scripts (the stable builder) and replace Next/React 18 with React 17
npm install react-scripts react@17.0.2 react-dom@17.0.2 --force >/dev/null 2>&1

# 3️⃣ Update package.json for CRA Build
echo "📝 Updating package.json to use the 'react-scripts build' command..."
# Use sed to quickly replace the old "build" script with the new one.
# It uses 'dist' as the output folder, which is typical for CRA.
sed -i 's/"build": "next build"/"build": "react-scripts build",\n    "export": "mv build dist"/' package.json
# Also update the 'deploy' script to point to the new 'dist' folder
sed -i 's/"deploy": "gh-pages -d out -b gh-pages -r/"deploy": "gh-pages -d dist -b gh-pages -r/' package.json


# 4️⃣ Run the Stable Build
echo "🏗️ Running stable 'react-scripts build' (This creates the 'build' folder)..."
# This build command is much less likely to crash on Termux.
if ! npm run build ; then
    echo "🛑 BUILD FAILED even with stable React build. Please report this error."
    exit 1
fi

# 5️⃣ Move/Rename Output Directory
echo "📦 Renaming 'build' directory to 'dist' for gh-pages deployment..."
rm -rf dist 2>/dev/null || true # Cleanup old 'dist' folder if it exists
mv build dist

# 6️⃣ Deploy to GitHub Pages
echo "🚢 Deploying 'dist' directory to 'gh-pages' branch..."
npm run deploy >/dev/null 2>&1

# 7️⃣ Done
echo "✅ Deployment complete! The build is now stable for Termux."
echo "---------------------------------------------------------"
echo "🌐 Site updated at: https://jabathykini-hub.github.io/PEA2025/"
echo "---------------------------------------------------------"
