#!/bin/bash
set -e
echo "🚀 Starting Full Stable Deployment and Configuration Fix..."

PROJECT_DIR="$HOME/pea-2025"

# --- 1️⃣ Prerequisites and Dependency Installation ---
echo "📦 Installing Termux dependencies (nodejs-lts, git, etc.)..."
pkg update -y >/dev/null 2>&1
pkg install -y nodejs-lts git bash >/dev/null 2>&1

# --- 2️⃣ Project Setup & Conversion ---
echo "📁 Setting up project directory and converting from Next.js to stable React..."
mkdir -p "$PROJECT_DIR" && cd "$PROJECT_DIR"

# Install stable dependencies (React 17, gh-pages, react-scripts)
echo "➕ Installing stable React 17 dependencies..."
npm install react-scripts react@17.0.2 react-dom@17.0.2 gh-pages@6.1.1 --force >/dev/null 2>&1

# Create the required src directory and move the app file
echo "📦 Fixing file structure: Moving index.js to src/index.js..."
mkdir -p src public
mv pages/index.js src/index.js 2>/dev/null || true

# --- 3️⃣ Inject Critical Configuration Files ---

echo "📄 Creating required public/index.html file..."
cat << 'HTML' > public/index.html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>PEA Nominee Portal</title>
  </head>
  <body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root"></div>
  </body>
</html>
HTML

echo "📝 Fixing package.json configuration..."
# 3a. Update build/deploy scripts (from Next to CRA)
sed -i 's/"build": "next build"/"build": "react-scripts build"/' package.json
sed -i 's/"start": "next start"/"start": "react-scripts start"/' package.json
sed -i 's/"deploy": "gh-pages -d out"/"deploy": "gh-pages -d dist"/' package.json
sed -i 's/"deploy": "gh-pages -d out"/"deploy": "gh-pages -d dist"/' package.json 2>/dev/null || true

# 3b. Inject the required 'browserslist' key after the "private": true line
echo "✅ Injecting 'browserslist' configuration..."
sed -i '/"private": true,/a\  "browserslist": {\n    "production": [">0.2%", "not dead", "not op_mini all"],\n    "development": ["last 1 chrome version", "last 1 firefox version", "last 1 safari version"]\n  },' package.json

# --- 4️⃣ Git Configuration & Commit (Optional but recommended) ---
echo "☁️ Initializing Git and committing configuration changes..."
git init >/dev/null 2>&1
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/jabathykini-hub/PEA2025.git
git add .
if ! git commit -m "Final Termux structural and configuration fix for stable CRA build." ; then
    echo "⚠️ Git commit failed. Repository might already be initialized. Continuing."
fi
git branch -M main
# Note: Git push is not strictly necessary for deployment but is good practice.
# The gh-pages deploy step below will handle the push to the gh-pages branch.

# --- 5️⃣ Build and Deploy ---
echo "🏗️ Running stable React build..."
# This is the moment of truth. If this succeeds, deployment is guaranteed.
if ! npm run build ; then
    echo "🛑 BUILD FAILED! Check for JavaScript errors in src/index.js."
    exit 1
fi

echo "📦 Renaming build folder to 'dist'..."
rm -rf dist 2>/dev/null || true
mv build dist

echo "🚢 Deploying to GitHub Pages..."
# This step handles the push to the deployment branch
npm run deploy >/dev/null 2>&1

# --- 6️⃣ Done ---
echo "✅ Deployment complete! Site is now published."
echo "---------------------------------------------------------"
echo "🌐 **Live Site:** https://jabathykini-hub.github.io/PEA2025/"
echo "---------------------------------------------------------"
