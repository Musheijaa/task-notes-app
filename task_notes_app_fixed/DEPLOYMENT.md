# Deployment Guide: Task Notes App on Render

## Prerequisites

1. **Firebase Project** (Free tier is sufficient)
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create a new project
   - Enable Firestore Database (create in test mode for development)
   - Register a web app in your project

2. **Render Account**
   - Sign up at [render.com](https://render.com)
   - Connect your GitHub account (or upload via Web Service manually)

3. **Git Repository**
   - Push this project to GitHub
   - Make the repository public (or give Render access to private repo)

## Step 1: Set Up Firebase

### 1.1 Get Firebase Credentials
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select or create your project
3. Go to **Project Settings** (gear icon)
4. Under **Your apps** section, find your web app
5. Copy these values:
   - API Key
   - App ID
   - Messaging Sender ID
   - Project ID
   - Auth Domain (format: `projectname.firebaseapp.com`)
   - Storage Bucket (format: `projectname.appspot.com`)
   - Measurement ID (optional, can be empty)

### 1.2 Set Up Firestore Database
1. In Firebase Console, go to **Build** > **Firestore Database**
2. Click **Create Database**
3. Start in **Test Mode** (for development)
4. Select your preferred region
5. Click **Create**

### 1.3 Set Firestore Security Rules (Important for Production)
Replace the default rules with:

```json
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /tasks/{document=**} {
      // Allow anyone to read/write for now
      // TODO: Add proper authentication before production
      allow read, write: if true;
    }
  }
}
```

## Step 2: Deploy on Render

### Option A: Using GitHub (Recommended)

1. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Prepare for Render deployment"
   git push origin main
   ```

2. **Connect to Render**
   - Go to [render.com/dashboard](https://render.com/dashboard)
   - Click **New +** > **Web Service**
   - Select **Build and deploy from a Git repository**
   - Connect your GitHub account and select this repository
   - Configure the service:
     - **Name**: `task-notes-app`
     - **Root Directory**: `.` (leave empty)
     - **Environment**: Select from dropdown or leave default
     - **Build Command**: 
       ```
       flutter pub get && flutter build web --release
       ```
     - **Start Command**:
       ```
       npm install -g http-server && http-server ./build/web -p $PORT --cors -o false
       ```
     - **Plan**: Free (or upgrade as needed)

3. **Add Environment Variables**
   - In Render dashboard, go to your service
   - Click **Environment** in the sidebar
   - Add these environment variables (from Step 1.1):
     - `FIREBASE_API_KEY`
     - `FIREBASE_APP_ID`
     - `FIREBASE_MESSAGING_SENDER_ID`
     - `FIREBASE_PROJECT_ID`
     - `FIREBASE_AUTH_DOMAIN`
     - `FIREBASE_STORAGE_BUCKET`
     - `FIREBASE_MEASUREMENT_ID`

4. **Deploy**
   - Click **Deploy** button
   - Wait for build to complete (~10-15 minutes first time)
   - Your app will be live at `https://task-notes-app.onrender.com` (or custom name)

### Option B: Using Docker

1. **Push to GitHub** (with Dockerfile included)

2. **Deploy on Render**
   - Click **New +** > **Web Service**
   - Select **Build and deploy from a Git repository**
   - Configure:
     - **Runtime**: Docker
     - No build/start commands needed (uses Dockerfile)
   - Add the same environment variables as Option A

## Step 3: Verify Deployment

After deployment completes:

1. Visit your Render URL (e.g., `https://task-notes-app.onrender.com`)
2. Test the app:
   - Add a new task
   - Toggle task completion
   - Delete a task
   - Verify tasks persist after refresh

## Troubleshooting

### "Failed to load tasks" error
- Check Firebase credentials are correctly set in Render environment variables
- Verify Firestore Database is created and in test mode
- Check Firestore security rules allow read/write

### Build fails with Flutter not found
- Make sure build command includes `flutter pub get`
- Check that Flutter is installed (Render includes it in standard build environment)

### Port-related errors
- Make sure start command uses `$PORT` variable
- Don't hardcode port numbers

## Production Checklist

Before going to production:

- [ ] Set up proper Firebase authentication (sign-up, login)
- [ ] Update Firestore security rules for authenticated users only
- [ ] Use Render paid plan (free plan may be too slow)
- [ ] Set up custom domain
- [ ] Enable HTTPS (automatic on Render)
- [ ] Add rate limiting and backup strategies
- [ ] Set up monitoring/alerts for errors

## Local Development

To test before deploying:

1. **Create .env file locally**
   ```bash
   cp .env.example .env.local
   ```

2. **Fill in Firebase credentials**
   ```
   FIREBASE_API_KEY=your_api_key_here
   ...
   ```

3. **Build web app locally**
   ```bash
   flutter build web --release \
     --dart-define=FIREBASE_API_KEY=$FIREBASE_API_KEY \
     --dart-define=FIREBASE_APP_ID=$FIREBASE_APP_ID \
     # ... (repeat for all variables)
   ```

4. **Serve locally**
   ```bash
   npm install -g http-server
   cd build/web
   http-server -p 8080 --cors
   ```

## Additional Resources

- [Firebase Documentation](https://firebase.google.com/docs)
- [Render Deployment Guide](https://render.com/docs)
- [Flutter Web Deployment](https://flutter.dev/docs/deployment/web)
- [Firestore Best Practices](https://firebase.google.com/docs/firestore/best-practices)

## Support

Issues or questions? Check:
1. Render logs in dashboard
2. Firebase console for database status
3. Browser console for JavaScript errors
4. Flutter DevTools (if running locally)
