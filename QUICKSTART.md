# NTLM Test App - Quick Start Guide

## ✅ What's Installed

Your NTLM authentication test application is ready to use! Here's what you have:

### Server Files
- **server.js** - Express server with NTLM middleware
- **config.js** - Configuration and mock user database
- **public/index.html** - Web dashboard UI
- **package.json** - Project dependencies
- **test-ntlm.ps1** - PowerShell test script

### Features
✓ NTLM authentication without Active Directory  
✓ Simple in-memory user database  
✓ Web UI for testing  
✓ REST API endpoints  
✓ PowerShell testing script included  

---

## 🚀 Starting the Server

The server is **already running** on `http://localhost:3000`

To start it manually in the future:
```powershell
npm start
```

For development with auto-reload:
```powershell
npm run dev
```

---

## 📝 Test Credentials

Use these credentials to test NTLM authentication:

| Username | Domain | Password |
| --- | --- | --- |
| user1 | testdomain | password1 |
| user2 | testdomain | password2 |
| admin | localhost | admin123 |

**Format**: `domain\username` (e.g., `testdomain\user1`)

---

## 🌐 Web UI

Open your browser and go to:

```
http://localhost:3000
```

You'll see a dashboard with:
- ✓ Current NTLM authentication status
- ✓ Buttons to test API endpoints
- ✓ Response viewer showing authentication info

### Dashboard Buttons

1. **Check NTLM Status** - Shows if you're authenticated and your user info
2. **Access Protected Resource** - Tests the protected endpoint
3. **List Test Users** - Shows available test credentials

---

## 🧪 Testing with PowerShell

Use the included test script to verify everything works:

```powershell
.\test-ntlm.ps1 -Username "testdomain\user1" -Password "password1" -Server "http://localhost:3000"
```

Or with defaults:
```powershell
.\test-ntlm.ps1
```

This will run three tests:
1. Check NTLM status
2. Access protected resource
3. List test users

---

## 🔧 Testing with cURL

If you have cURL installed, test NTLM authentication:

```bash
# Check status with credentials
curl -i --ntlm -u "testdomain\user1:password1" http://localhost:3000/api/status

# Access protected resource
curl -i --ntlm -u "testdomain\user1:password1" http://localhost:3000/api/protected

# List test users (no auth required)
curl http://localhost:3000/api/test-users
```

---

## 📚 API Endpoints

### Public Endpoints (No authentication required)

**GET /api/status**
- Shows NTLM authentication info
- Response includes: username, domain, workstation

**GET /api/test-users**
- Lists available test users for authentication

### Protected Endpoints (Requires NTLM authentication)

**GET /api/protected**
- Returns protected data only to authenticated users
- Response includes: secret message, timestamp

---

## ⚙️ Customization

### Change Port

Edit `config.js`:
```javascript
export const serverConfig = {
  port: 3000,  // Change to 3001, 5000, etc.
  // ...
};
```

Then restart the server.

### Add More Test Users

Edit `config.js`:
```javascript
export const mockUsers = {
  'testdomain\\user1': 'password1',
  'testdomain\\user2': 'password2',
  'testdomain\\user3': 'password3',  // Add here
  'localhost\\admin': 'admin123'
};
```

### Change Domain Name

Edit `config.js`:
```javascript
export const serverConfig = {
  port: 3000,
  host: 'localhost',
  ntlm: {
    domain: 'mycompany',  // Change from 'testdomain'
    workstation: 'TESTPC'
  }
};
```

---

## 🐛 Troubleshooting

### Server Won't Start
```powershell
# Kill process on port 3000
npx kill-port 3000

# Then start again
npm start
```

### "Module not found" Error
```powershell
npm install
```

### Can't Connect to Server
- Verify server is running: Check terminal for ✓ message
- Check URL: http://localhost:3000 (not https)
- Check firewall: May need to allow port 3000

### NTLM Not Working in Browser
- Browser support varies (Edge/IE work best on Windows)
- Try PowerShell or cURL instead
- Ensure you're on localhost or trusted intranet zone

### "User not authorized" Response
- Check username format: `domain\username`
- Verify exact spelling (including case)
- Ensure user exists in `config.js`

---

## 📂 Project Structure

```
ntlmtest/
├── server.js              # Express server (main application)
├── config.js              # Config and mock users (edit to customize)
├── package.json           # Dependencies
├── test-ntlm.ps1          # PowerShell test script
├── README.md              # Full documentation
├── QUICKSTART.md          # This file
├── .gitignore             # Git ignore file
└── public/
    └── index.html         # Web UI dashboard
```

---

## 🔐 Important Notes

⚠️ **Development Only**: This is for testing NTLM authentication in development  
⚠️ **No Security Hardening**: Not suitable for production use  
⚠️ **Plain Text Passwords**: Credentials stored in plain text for testing  
⚠️ **HTTP Only**: Does not use HTTPS (use HTTPS in production)  

---

## 📖 Common Tasks

### View Server Logs
The terminal running `npm start` shows all server activity

### Stop the Server
In the terminal running the server, press `Ctrl+C`

### Reset Test Users
Edit `config.js` and restart the server

### Run Without Web UI
Just use the API endpoints directly:
```powershell
Invoke-WebRequest -Uri "http://localhost:3000/api/status" -Authentication NTLM -Credential $cred
```

---

## 🆘 Need Help?

1. **Check the terminal**: Look for error messages when starting the server
2. **Verify Node.js**: Run `node --version` (should be 16+)
3. **Verify npm**: Run `npm --version`
4. **Check port**: Make sure port 3000 is available
5. **Test users**: Use the `/api/test-users` endpoint to verify available credentials

---

## 📞 Next Steps

1. ✅ Start the server (already running!)
2. ✅ Open http://localhost:3000 in your browser
3. ✅ Click "Check NTLM Status" to test
4. ✅ Try the other endpoints
5. ✅ Use PowerShell script to automate testing
6. ✅ Customize config.js as needed

Enjoy testing NTLM authentication! 🚀
