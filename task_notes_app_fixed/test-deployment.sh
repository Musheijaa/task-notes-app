#!/bin/bash

# Verify deployment works correctly

echo "🔍 Testing Task Notes App Deployment..."
echo ""

read -p "Enter your Render app URL (e.g., https://task-notes-app.onrender.com): " APP_URL

if [ -z "$APP_URL" ]; then
    echo "❌ No URL provided"
    exit 1
fi

echo ""
echo "Testing: $APP_URL"
echo ""

# Test 1: App loads
echo -n "1. Testing app loads... "
if curl -s "$APP_URL" | grep -q "task\|Task"; then
    echo "✅ OK"
else
    echo "⚠️  Could not verify (might need more time to initialize)"
fi

# Test 2: Check for Flutter web signature
echo -n "2. Checking Flutter web app... "
if curl -s "$APP_URL" | grep -q "flutter\|dartLoader"; then
    echo "✅ OK"
else
    echo "❌ Not a Flutter app"
fi

# Test 3: Response time
echo -n "3. Checking response time... "
START=$(date +%s%N)
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL")
END=$(date +%s%N)
TIME_MS=$(( (END - START) / 1000000 ))

if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ OK (${TIME_MS}ms)"
else
    echo "❌ HTTP $HTTP_CODE"
fi

echo ""
echo "Next steps to fully test:"
echo "1. Open $APP_URL in your browser"
echo "2. Create a new task"
echo "3. Refresh the page"
echo "4. Verify task is still there (data persisted)"
echo "5. Delete the task"
echo "6. Toggle the theme"
echo ""
echo "If all tests pass, your deployment is successful! 🎉"
