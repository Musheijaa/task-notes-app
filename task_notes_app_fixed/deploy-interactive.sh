#!/bin/bash

# Colors for better readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║  Task Notes App - Firebase + Render Deployment Setup      ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

echo ""
echo -e "${YELLOW}IMPORTANT: Before continuing, you must:${NC}"
echo "1. Create a Firebase project at https://console.firebase.google.com"
echo "2. Register a web app in Firebase"
echo "3. Have your Firebase credentials ready"
echo ""
read -p "Have you done these steps? (yes/no): " firebase_ready

if [[ "$firebase_ready" != "yes" ]]; then
    echo -e "${RED}Please go to Firebase Console first!${NC}"
    echo "Visit: https://console.firebase.google.com"
    exit 1
fi

echo ""
echo -e "${GREEN}Great! Let's collect your Firebase credentials...${NC}"
echo ""

# Collect Firebase credentials
read -p "Firebase API Key: " FIREBASE_API_KEY
read -p "Firebase App ID: " FIREBASE_APP_ID
read -p "Firebase Messaging Sender ID: " FIREBASE_MESSAGING_SENDER_ID
read -p "Firebase Project ID: " FIREBASE_PROJECT_ID
read -p "Firebase Auth Domain: " FIREBASE_AUTH_DOMAIN
read -p "Firebase Storage Bucket: " FIREBASE_STORAGE_BUCKET
read -p "Firebase Measurement ID (optional): " FIREBASE_MEASUREMENT_ID

# Save to .env file (for reference)
cat > .env.credentials << EOF
FIREBASE_API_KEY=$FIREBASE_API_KEY
FIREBASE_APP_ID=$FIREBASE_APP_ID
FIREBASE_MESSAGING_SENDER_ID=$FIREBASE_MESSAGING_SENDER_ID
FIREBASE_PROJECT_ID=$FIREBASE_PROJECT_ID
FIREBASE_AUTH_DOMAIN=$FIREBASE_AUTH_DOMAIN
FIREBASE_STORAGE_BUCKET=$FIREBASE_STORAGE_BUCKET
FIREBASE_MEASUREMENT_ID=$FIREBASE_MEASUREMENT_ID
EOF

echo ""
echo -e "${GREEN}✓ Credentials saved to .env.credentials${NC}"
echo ""

# Prepare for Render
echo -e "${YELLOW}Now let's prepare for Render deployment...${NC}"
echo ""

# Commit changes
echo -e "${BLUE}Step 1: Pushing to GitHub${NC}"
git add .
git commit -m "Configure Firebase for Render deployment" || true
echo -e "${YELLOW}Ready to push? (run: git push origin main)${NC}"

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}NEXT STEPS FOR RENDER:${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════${NC}"
echo ""
echo "1. Push to GitHub:"
echo "   ${BLUE}git push origin main${NC}"
echo ""
echo "2. Go to Render: ${BLUE}https://render.com${NC}"
echo ""
echo "3. Click ${BLUE}'New +' > 'Web Service'${NC}"
echo ""
echo "4. Connect your GitHub repository"
echo ""
echo "5. Configure with these settings:"
echo "   Name: ${BLUE}task-notes-app${NC}"
echo "   Root: ${BLUE}.(leave blank)${NC}"
echo ""
echo "6. Build Command:"
echo "   ${BLUE}flutter pub get && flutter build web --release \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_API_KEY=\$FIREBASE_API_KEY \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_APP_ID=\$FIREBASE_APP_ID \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_MESSAGING_SENDER_ID=\$FIREBASE_MESSAGING_SENDER_ID \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_PROJECT_ID=\$FIREBASE_PROJECT_ID \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_AUTH_DOMAIN=\$FIREBASE_AUTH_DOMAIN \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_STORAGE_BUCKET=\$FIREBASE_STORAGE_BUCKET \\${NC}"
echo "   ${BLUE}--dart-define=FIREBASE_MEASUREMENT_ID=\$FIREBASE_MEASUREMENT_ID${NC}"
echo ""
echo "7. Start Command:"
echo "   ${BLUE}npm install -g http-server && http-server ./build/web -p \$PORT --cors -o false${NC}"
echo ""
echo "8. Add Environment Variables in Render:"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
cat .env.credentials | sed 's/^/   /' 
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "9. Click ${BLUE}'Create Web Service'${NC}"
echo ""
echo "10. Wait 10-15 minutes for deployment to complete"
echo ""
echo -e "${GREEN}✅ Your app will be live at: https://task-notes-app.onrender.com${NC}"
echo ""
