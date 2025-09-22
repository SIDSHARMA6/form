# Google Sign-In Web Setup Instructions

## Problem
You're getting "Authorization Error" because we're using an Android client ID for web authentication.

## Solution
You need to create a Web Client ID in Google Cloud Console:

### Step 1: Go to Google Cloud Console
1. Visit: https://console.cloud.google.com/
2. Select project: **formphonix** (492272218176)

### Step 2: Enable Google Sign-In API
1. Go to **APIs & Services** → **Library**
2. Search for "Google Sign-In API" or "Google+ API"
3. Click **Enable** if not already enabled

### Step 3: Create Web Client ID
1. Go to **APIs & Services** → **Credentials**
2. Click **+ CREATE CREDENTIALS** → **OAuth 2.0 Client IDs**
3. Choose **Web application**
4. Name it: "Phoenix Web App"
5. Add **Authorized JavaScript origins**:
   ```
   http://localhost:3000
   http://localhost:8080
   http://127.0.0.1:3000
   http://127.0.0.1:8080
   https://formphonix.web.app
   https://formphonix.firebaseapp.com
   ```
6. Add **Authorized redirect URIs**:
   ```
   http://localhost:3000/auth/handler.html
   http://127.0.0.1:3000/auth/handler.html
   https://formphonix.web.app/auth/handler.html
   https://formphonix.firebaseapp.com/auth/handler.html
   ```
7. Click **Create**

### Step 4: Copy the Web Client ID
After creating, you'll get a client ID that looks like:
`492272218176-XXXXXXXXXX.apps.googleusercontent.com`

### Step 5: Update Your Code
Replace `YOUR_WEB_CLIENT_ID_HERE` in `web/index.html` with your new web client ID.

## Current Status
- ❌ Using Android client ID for web (causes error)
- ✅ Need to create proper web client ID
- ✅ Code is ready, just needs the correct client ID

## Quick Test
After updating the client ID, run:
```bash
flutter run -d chrome --web-renderer canvaskit
```