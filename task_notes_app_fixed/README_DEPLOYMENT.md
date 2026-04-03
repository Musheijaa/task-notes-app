# Task Notes App - Render Deployment Ready

A Flutter task management application configured for cloud deployment on Render with Firebase Firestore backend.

## Features

✨ **Task Management**
- Create, read, update, and delete tasks
- Mark tasks as complete/pending
- Organize by priority (High, Medium, Low)
- Add optional descriptions

🌓 **Theme Support**
- Light and dark mode toggle
- Persistent theme preferences (TODO)
- Beautiful Material Design UI

☁️ **Cloud Backend**
- Firebase Firestore for data persistence
- Real-time synchronization
- Scalable cloud storage

🚀 **Production Ready**
- Deployed on Render
- Environment-based configuration
- Docker containerization support
- CORS enabled for web access

## Quick Start

### Local Development

1. **Clone and setup**
   ```bash
   git clone <your-repo-url>
   cd task-notes-app
   flutter pub get
   ```

2. **Configure Firebase**
   - Copy `.env.example` to `.env.local`
   - Fill in your Firebase credentials
   - See DEPLOYMENT.md for detailed setup

3. **Run on desktop (Linux, macOS, Windows)**
   ```bash
   flutter run -d linux    # or macos, windows
   ```

4. **Run on web**
   ```bash
   flutter run -d chrome
   ```

### Deploy on Render

See [DEPLOYMENT.md](./DEPLOYMENT.md) for comprehensive deployment instructions.

**Quick summary:**
1. Create Firebase project
2. Push to GitHub
3. Connect to Render
4. Add Firebase environment variables
5. Deploy!

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── theme.dart               # Theme definitions
├── constants.dart           # App constants & strings
├── models/
│   └── task_item.dart       # Task data model
├── providers/
│   └── task_provider.dart   # State management (Firebase)
├── screens/
│   ├── home_screen.dart     # Main task list
│   └── add_task_screen.dart # New task creation
└── widgets/
    └── task_card.dart       # Task list item widget
```

## Technology Stack

- **Frontend:** Flutter 3.9+
- **State Management:** Provider
- **Backend:** Firebase Firestore
- **Hosting:** Render
- **Web Server:** http-server
- **Containerization:** Docker

## Environment Variables

Firebase credentials (set in Render):
- `FIREBASE_API_KEY`
- `FIREBASE_APP_ID`
- `FIREBASE_MESSAGING_SENDER_ID`
- `FIREBASE_PROJECT_ID`
- `FIREBASE_AUTH_DOMAIN`
- `FIREBASE_STORAGE_BUCKET`
- `FIREBASE_MEASUREMENT_ID`

## Troubleshooting

### Database not connecting
- Verify Firebase credentials in environment variables
- Check Firestore database is created and in test mode
- Ensure Render build output shows successful Flutter web build

### Build fails on Render
- Check build logs in Render dashboard
- Verify `render.yaml` uses correct Flutter commands
- Ensure `package.json` is in repo root

### App not loading
- Clear browser cache and reload
- Check browser console for JavaScript errors
- Verify Render service is running (check status in dashboard)

## Next Steps

### Production Improvements
- [ ] Add user authentication
- [ ] Implement Firestore security rules
- [ ] Add offline support with local cache
- [ ] Set up error logging/monitoring
- [ ] Optimize performance and bundle size

### Features to Add
- [ ] Task filtering by status/priority
- [ ] Task search functionality
- [ ] Due dates and reminders
- [ ] Task categories/tags
- [ ] Collaborative tasks (shared lists)

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Render Documentation](https://render.com/docs)
- [DEPLOYMENT.md](./DEPLOYMENT.md) - Step-by-step deployment guide

## License

This project is open source and available under the MIT License.

## Support

Encountering issues? 
1. Check [DEPLOYMENT.md](./DEPLOYMENT.md) troubleshooting section
2. Review Render deployment logs
3. Check Firebase console for database status
4. Review Flutter console output for errors
