#!/bin/bash

echo "===== Firebase & Render Deployment Helper ====="
echo ""
echo "Follow these steps carefully:"
echo ""
echo "STEP 1: Firebase Setup"
echo "====================="
echo "✓ Open: https://console.firebase.google.com/"
echo "✓ Create a new project (name: task-notes-app-yourname)"
echo "✓ Wait for it to finish"
echo "✓ Click '</>' icon to register a web app"
echo "✓ Uncheck 'Also set up hosting' (we use Render for that)"
echo "✓ Copy the configuration object"
echo ""
echo "STEP 2: Firestore Database"
echo "========================="
echo "✓ In Firebase console, go to 'Build' > 'Firestore Database'"
echo "✓ Click 'Create Database'"
echo "✓ Select 'Start in test mode' (for development)"
echo "✓ Choose your region"
echo "✓ Click 'Create'"
echo ""
echo "STEP 3: Get Your Credentials"
echo "============================"
echo "✓ Go to Project Settings (gear icon)"
echo "✓ Click the Web app you created"
echo "✓ You'll see firebaseConfig with these values:"
echo "   - apiKey"
echo "   - appId"
echo "   - messagingSenderId"
echo "   - projectId"
echo "   - authDomain"
echo "   - storageBucket"
echo "   - measurementId"
echo ""
echo "═══════════════════════════════════════════════════"
echo ""
echo "Ready? Let's set up your .env file!"
echo ""
echo "Enter your Firebase credentials below:"
echo ""

read -p "API Key: " api_key
read -p "App ID: " app_id
read -p "Messaging Sender ID: " messaging_sender_id
read -p "Project ID: " project_id
read -p "Auth Domain: " auth_domain
read -p "Storage Bucket: " storage_bucket
read -p "Measurement ID (optional, press Enter to skip): " measurement_id

# Create .env.firebase file
cat > .env.firebase << EOF
FIREBASE_API_KEY=$api_key
FIREBASE_APP_ID=$app_id
FIREBASE_MESSAGING_SENDER_ID=$messaging_sender_id
FIREBASE_PROJECT_ID=$project_id
FIREBASE_AUTH_DOMAIN=$auth_domain
FIREBASE_STORAGE_BUCKET=$storage_bucket
FIREBASE_MEASUREMENT_ID=${measurement_id:-}
EOF

echo ""
echo "✅ Saved credentials to .env.firebase"
echo ""
echo "═══════════════════════════════════════════════════"
echo ""
echo "STEP 4: Commit to GitHub"
echo "======================="
echo "Run these commands:"
echo ""
echo "  git add ."
echo "  git commit -m 'Configure Firebase for Render deployment'"
echo "  git push origin main"
echo ""
echo "═══════════════════════════════════════════════════"
echo ""
echo "STEP 5: Deploy on Render"
echo "======================="
echo "✓ Go to: https://render.com"
echo "✓ Sign in with GitHub"
echo "✓ Click 'New +' > 'Web Service'"
echo "✓ Connect your GitHub repository"
echo "✓ Configure:"
echo "  Name: task-notes-app"
echo "  Root Directory: . (leave blank)"
echo "  Build Command:"
echo "    flutter pub get && flutter build web --release --dart-define=FIREBASE_API_KEY=\$FIREBASE_API_KEY --dart-define=FIREBASE_APP_ID=\$FIREBASE_APP_ID --dart-define=FIREBASE_MESSAGING_SENDER_ID=\$FIREBASE_MESSAGING_SENDER_ID --dart-define=FIREBASE_PROJECT_ID=\$FIREBASE_PROJECT_ID --dart-define=FIREBASE_AUTH_DOMAIN=\$FIREBASE_AUTH_DOMAIN --dart-define=FIREBASE_STORAGE_BUCKET=\$FIREBASE_STORAGE_BUCKET --dart-define=FIREBASE_MEASUREMENT_ID=\$FIREBASE_MEASUREMENT_ID"
echo "  Start Command:"
echo "    npm install -g http-server && http-server ./build/web -p \$PORT --cors -o false"
echo ""
echo "✓ Select Plan: Free"
echo "✓ Click 'Advanced' and add these Environment Variables:"
echo ""
cat .env.firebase | while read line; do
  echo "  $line"
done
echo ""
echo "✓ Click 'Create Web Service'"
echo "✓ Wait 10-15 minutes for build to complete"
echo ""
echo "✅ Your app will be live at https://task-notes-app.onrender.com"
echo ""
