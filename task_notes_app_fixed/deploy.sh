#!/bin/bash

# Task Notes App - Deployment Helper Script
# This script guides you through the Render + Firebase deployment

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}"
cat << "EOF"
╔════════════════════════════════════════════════════════════════╗
║     Task Notes App - Firebase + Render Deployment Helper     ║
║                                                               ║
║  This script will help you deploy to Render with Firebase   ║
║  Some steps require manual action in the web browser        ║
╚════════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

# Step 0: Verify Git is ready
echo -e "${YELLOW}[STEP 0] Verifying Git setup...${NC}"
cd "$(dirname "$0")"

if ! git log -1 > /dev/null 2>&1; then
    echo -e "${RED}✗ Not a git repository${NC}"
    exit 1
fi

if ! git remote get-url origin > /dev/null 2>&1; then
    echo -e "${RED}✗ No git remote found${NC}"
    exit 1
fi

REPO_URL=$(git remote get-url origin)
echo -e "${GREEN}✓ Git ready${NC}"
echo "  Repository: $REPO_URL"
echo ""

# Step 1: Firebase Setup
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}[STEP 1] Firebase Setup${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${YELLOW}⚠️  YOU NEED TO DO THIS MANUALLY IN YOUR BROWSER:${NC}"
echo ""
echo "1. Open: ${BLUE}https://console.firebase.google.com/${NC}"
echo ""
echo "2. Create a new project:"
echo "   • Click 'Create a project'"
echo "   • Project name: ${BLUE}task-notes-app${NC}"
echo "   • Choose your region"
echo "   • Click 'Create project'"
echo "   • Wait 1-2 minutes..."
echo ""
echo "3. Register web app:"
echo "   • Click '</>' (Web icon)"
echo "   • App nickname: ${BLUE}task-notes-web${NC}"
echo "   • Leave other options default"
echo "   • Click 'Register app'"
echo ""
echo "4. Copy your Firebase credentials from the code snippet"
echo "   You'll see something like:"
echo "   ${BLUE}const firebaseConfig = {${NC}"
echo "   ${BLUE}  apiKey: \"AIzaSy...\",${NC}"
echo "   ${BLUE}  appId: \"1:123456...\",${NC}"
echo "   ${BLUE}  authDomain: \"project.firebaseapp.com\",${NC}"
echo "   ${BLUE}  messagingSenderId: \"123456789\",${NC}"
echo "   ${BLUE}  projectId: \"my-project\",${NC}"
echo "   ${BLUE}  storageBucket: \"my-project.appspot.com\",${NC}"
echo "   ${BLUE}  measurementId: \"G-ABC123\"${NC}"
echo "   ${BLUE}};${NC}"
echo ""
echo "5. Create Firestore Database:"
echo "   • Go to: Build > Firestore Database"
echo "   • Click 'Create Database'"
echo "   • Select 'Start in test mode'"
echo "   • Choose your region"
echo "   • Click 'Create'"
echo ""
echo -e "${YELLOW}Press Enter once you've completed Step 1...${NC}"
read

# Step 2: Collect Firebase Credentials
echo ""
echo -e "${YELLOW}[GATHERING CREDENTIALS]${NC}"
echo ""
echo -e "${YELLOW}Now enter your 7 Firebase credentials:${NC}"
echo "(You just copied these from Firebase Console)"
echo ""

read -p "1. FIREBASE_API_KEY: " FIREBASE_API_KEY
read -p "2. FIREBASE_APP_ID: " FIREBASE_APP_ID
read -p "3. FIREBASE_MESSAGING_SENDER_ID: " FIREBASE_MESSAGING_SENDER_ID
read -p "4. FIREBASE_PROJECT_ID: " FIREBASE_PROJECT_ID
read -p "5. FIREBASE_AUTH_DOMAIN: " FIREBASE_AUTH_DOMAIN
read -p "6. FIREBASE_STORAGE_BUCKET: " FIREBASE_STORAGE_BUCKET
read -p "7. FIREBASE_MEASUREMENT_ID (optional, press Enter to skip): " FIREBASE_MEASUREMENT_ID

echo ""
echo -e "${GREEN}✓ Credentials saved${NC}"
echo ""

# Step 3: Create .env file for reference
cat > .env.deployment << EOF
FIREBASE_API_KEY=$FIREBASE_API_KEY
FIREBASE_APP_ID=$FIREBASE_APP_ID
FIREBASE_MESSAGING_SENDER_ID=$FIREBASE_MESSAGING_SENDER_ID
FIREBASE_PROJECT_ID=$FIREBASE_PROJECT_ID
FIREBASE_AUTH_DOMAIN=$FIREBASE_AUTH_DOMAIN
FIREBASE_STORAGE_BUCKET=$FIREBASE_STORAGE_BUCKET
FIREBASE_MEASUREMENT_ID=$FIREBASE_MEASUREMENT_ID
EOF

echo -e "${GREEN}✓ Saved to .env.deployment${NC}"
echo ""

# Step 4: Prepare GitHub
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}[STEP 2] Final GitHub Push${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo ""

git add .env.deployment
git commit -m "Add Firebase credentials for Render deployment" || true
git push origin main

echo -e "${GREEN}✓ Pushed to GitHub${NC}"
echo ""

# Step 5: Render Deployment
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}[STEP 3] Deploy on Render${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${YELLOW}⚠️  NOW DEPLOY ON RENDER (manual steps in browser):${NC}"
echo ""
echo "1. Open: ${BLUE}https://render.com${NC}"
echo ""
echo "2. Sign up/in with GitHub"
echo ""
echo "3. Click '${BLUE}New +${NC}' > '${BLUE}Web Service${NC}'"
echo ""
echo "4. Connect your repository: ${BLUE}$REPO_URL${NC}"
echo ""
echo "5. Configure with these settings:"
echo ""
echo "   Name: ${BLUE}task-notes-app${NC}"
echo ""
echo "   Root Directory: ${BLUE}.${NC}} (leave blank)"
echo ""
echo "   Build Command (copy & paste):"
echo "   ${BLUE}flutter pub get && flutter build web --release \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_API_KEY=\$FIREBASE_API_KEY \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_APP_ID=\$FIREBASE_APP_ID \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_MESSAGING_SENDER_ID=\$FIREBASE_MESSAGING_SENDER_ID \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_PROJECT_ID=\$FIREBASE_PROJECT_ID \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_AUTH_DOMAIN=\$FIREBASE_AUTH_DOMAIN \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_STORAGE_BUCKET=\$FIREBASE_STORAGE_BUCKET \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_MEASUREMENT_ID=\$FIREBASE_MEASUREMENT_ID${NC}"
echo ""
echo "   Start Command (copy & paste):"
echo "   ${BLUE}npm install -g http-server && http-server ./build/web -p \$PORT --cors -o false${NC}"
echo ""
echo "6. Add these Environment Variables in Render:"
echo ""
cat .env.deployment | sed 's/^/   /'
echo ""
echo "7. Select Plan: ${BLUE}Free${NC}"
echo ""
echo "8. Click ${BLUE}'Create Web Service'${NC}}"
echo ""
echo "9. Wait 10-15 minutes for build to complete"
echo ""
echo -e "${YELLOW}Press Enter once deployment is complete...${NC}"
read

echo ""
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}[STEP 4] Verify Deployment${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════${NC}"
echo ""

read -p "Enter your Render URL (e.g., https://task-notes-app.onrender.com): " RENDER_URL

echo ""
echo -e "${YELLOW}Testing your app...${NC}"
echo ""
echo "✓ Open: ${BLUE}$RENDER_URL${NC}"
echo "✓ Add a task with the '+' button"
echo "✓ Refresh the page - task should still be there"
echo "✓ Delete the task"
echo "✓ Toggle the theme"
echo ""

read -p "Did everything work? (yes/no): " deployment_success

if [[ "$deployment_success" == "yes" ]]; then
    echo ""
    echo -e "${GREEN}"
    cat << "EOF"
╔════════════════════════════════════════════════════════════════╗
║                     ✅ DEPLOYMENT SUCCESS! 🎉                ║
║                                                               ║
║  Your Task Notes App is now live on Render with Firebase!   ║
╚════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    echo "Your app is live at: ${BLUE}$RENDER_URL${NC}"
    echo ""
    echo "Next steps:"
    echo "• Share your app with friends!"
    echo "• Add features like task filtering"
    echo "• Set up Firebase Authentication"
    echo "• Implement Firestore security rules"
    echo ""
else
    echo ""
    echo -e "${RED}⚠️  Something went wrong${NC}"
    echo ""
    echo "Troubleshooting:"
    echo "1. Check Render logs (click 'Logs' tab)"
    echo "2. Verify all Firebase credentials are correct"
    echo "3. Check Firestore database exists"
    echo "4. Review: DEPLOYMENT.md for help"
    echo ""
fi

echo -e "${YELLOW}Cleaning up...${NC}"
rm -f .env.deployment
git add .
git commit -m "Deployment complete" || true

echo -e "${GREEN}Done!${NC}"
