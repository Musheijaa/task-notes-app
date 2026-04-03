# Render Deployment Checklist

## Pre-Deployment (Firebase Setup)

- [ ] Go to https://console.firebase.google.com
- [ ] Create a new Firebase project (name: `task-notes-app-yourname`)
- [ ] Wait for project creation to complete
- [ ] Click the `</>` Web icon to register a web app
- [ ] Copy the Firebase config (you'll need 7 values)
- [ ] In Firebase console, go to Build > Firestore Database
- [ ] Click "Create Database"
- [ ] Select "Start in test mode"
- [ ] Choose your region and click "Create"

## Firebase Credentials Needed

You'll need to copy these 7 values from Firebase Console > Project Settings > Web:

```
FIREBASE_API_KEY=                    # API Key
FIREBASE_APP_ID=                     # App ID
FIREBASE_MESSAGING_SENDER_ID=        # Sender ID
FIREBASE_PROJECT_ID=                 # Project ID
FIREBASE_AUTH_DOMAIN=                # Auth Domain (xxx.firebaseapp.com)
FIREBASE_STORAGE_BUCKET=             # Storage Bucket (xxx.appspot.com)
FIREBASE_MEASUREMENT_ID=             # Measurement ID (optional)
```

## GitHub Push

- [ ] `git add .`
- [ ] `git commit -m "Prepare for Render deployment"`
- [ ] `git push origin main`
- [ ] Verify repo is on GitHub

## Render Deployment

- [ ] Go to https://render.com
- [ ] Sign in with GitHub
- [ ] Click "New +" > "Web Service"
- [ ] Connect your repository
- [ ] Set configurations (see details below)
- [ ] Add environment variables (7 Firebase credentials)
- [ ] Click "Create Web Service"
- [ ] Wait 10-15 minutes
- [ ] Your app is live! 🎉

## Render Configuration Details

**Settings:**
- Name: `task-notes-app`
- Root: `. ` (leave blank)
- Runtime: Default

**Build Command:**
```
flutter pub get && flutter build web --release \
--dart-define=FIREBASE_API_KEY=$FIREBASE_API_KEY \
--dart-define=FIREBASE_APP_ID=$FIREBASE_APP_ID \
--dart-define=FIREBASE_MESSAGING_SENDER_ID=$FIREBASE_MESSAGING_SENDER_ID \
--dart-define=FIREBASE_PROJECT_ID=$FIREBASE_PROJECT_ID \
--dart-define=FIREBASE_AUTH_DOMAIN=$FIREBASE_AUTH_DOMAIN \
--dart-define=FIREBASE_STORAGE_BUCKET=$FIREBASE_STORAGE_BUCKET \
--dart-define=FIREBASE_MEASUREMENT_ID=$FIREBASE_MEASUREMENT_ID
```

**Start Command:**
```
npm install -g http-server && http-server ./build/web -p $PORT --cors -o false
```

**Environment Variables:**
Add all 7 Firebase credentials in Render's environment settings

## Troubleshooting

**If build fails:**
- Check Render logs for full error
- Verify all environment variables are set
- Check Firebase credentials are correct

**If app shows "Failed to load tasks":**
- Verify Firestore database is created
- Check security rules in Firestore
- Verify Firebase credentials in Render

**If app doesn't load:**
- Clear browser cache (Ctrl+Shift+Delete)
- Check browser console (F12 > Console tab)
- Verify Render service is running

## Success Indicators

✅ Render build completed successfully
✅ App loads in browser
✅ Can create a new task
✅ Task persists after page refresh
✅ Can delete tasks
✅ Theme toggle works
