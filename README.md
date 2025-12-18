# NTLM Authentication Test Application

A lightweight, simple web application for testing NTLM authentication without requiring an Active Directory environment.

## 🎯 Features

- **No AD Required**: Works with a simple in-memory user database
- **Lightweight**: Node.js + Express, minimal dependencies
- **Easy to Test**: Web UI and API endpoints included
- **NTLM Protocol Support**: Full NTLM negotiation handling
- **Multiple Test Users**: Pre-configured test credentials

## 📋 Prerequisites

- **Node.js** 16+ ([Download](https://nodejs.org/))
- Windows OS (for NTLM support) or a system with NTLM middleware support

## 🚀 Quick Start

### 1. Install Dependencies

```bash
npm install
```

### 2. Start the Server

```bash
npm start
```

Or for development with auto-reload:

```bash
npm run dev
```

### 3. Access the Application

Open your browser and navigate to:

```
http://localhost:3000
```

You should see the NTLM test dashboard.

## 🧪 Testing NTLM Authentication

### Via Web Browser

1. Open http://localhost:3000
2. Click "Check NTLM Status" to see current authentication info
3. Click "List Test Users" to see available credentials
4. Click "Access Protected Resource" to test protected endpoint

### Via cURL (Windows Command Prompt or PowerShell)

```bash
# Check NTLM status with credentials
curl -i --ntlm -u "testdomain\user1:password1" http://localhost:3000/api/status

# Access protected resource
curl -i --ntlm -u "testdomain\user1:password1" http://localhost:3000/api/protected

# List test users
curl http://localhost:3000/api/test-users
```

### Via PowerShell

```powershell
# Check status with NTLM auth
$cred = New-Object System.Management.Automation.PSCredential("testdomain\user1", (ConvertTo-SecureString "password1" -AsPlainText -Force))
Invoke-WebRequest -Uri "http://localhost:3000/api/status" -Authentication NTLM -Credential $cred

# Access protected resource
Invoke-WebRequest -Uri "http://localhost:3000/api/protected" -Authentication NTLM -Credential $cred
```

## 👥 Test Users

The following test credentials are available:

| Username | Domain | Password |
|----------|--------|----------|
| user1 | testdomain | password1 |
| user2 | testdomain | password2 |
| admin | localhost | admin123 |

**Format for use**: `domain\username` (e.g., `testdomain\user1`)

## 📚 API Endpoints

### Public Endpoints

**GET /api/status**
- Returns NTLM authentication status
- No authentication required
- Response includes username, domain, workstation info

**GET /api/test-users**
- Returns list of available test users
- No authentication required

### Protected Endpoints

**GET /api/protected**
- Returns protected data
- Requires valid NTLM authentication
- User must be in the authorized users list

## ⚙️ Configuration

Edit `config.js` to customize:

```javascript
// NTLM domain and workstation name
export const serverConfig = {
  port: 3000,
  host: 'localhost',
  ntlm: {
    domain: 'testdomain',
    workstation: 'TESTPC'
  }
};

// Add/remove test users
export const mockUsers = {
  'testdomain\\user1': 'password1',
  'testdomain\\user2': 'password2',
  'localhost\\admin': 'admin123'
};
```

## 📁 Project Structure

```
ntlmtest/
├── server.js          # Express server with NTLM middleware
├── config.js          # Configuration and mock user database
├── package.json       # Project dependencies
├── public/
│   └── index.html     # Web UI dashboard
└── README.md          # This file
```

## 🔍 How It Works

1. **NTLM Middleware**: The `express-ntlm` package handles NTLM protocol negotiation
2. **User Validation**: Custom middleware checks if authenticated user is in the mock user database
3. **Request Context**: Authenticated user info is attached to the request object
4. **Protected Routes**: Routes can require authentication before serving content

## 🐛 Troubleshooting

### "Cannot find module 'express-ntlm'"
Run `npm install` to install dependencies

### NTLM authentication not working in browser
- Browser support for NTLM varies (Internet Explorer/Edge work best on Windows)
- Try using cURL or PowerShell instead
- Ensure you're on localhost or a trusted intranet zone

### "User not authorized" error
Check that:
1. You're using the correct username format: `domain\username`
2. The credentials match exactly (including case sensitivity in some cases)
3. The user is listed in `config.js`

### Port already in use
Change the port in `config.js` or use:
```bash
npx kill-port 3000
```

## 💡 Use Cases

- **Development**: Test NTLM authentication without setting up AD
- **Integration Testing**: Verify NTLM-based applications
- **Learning**: Understand NTLM protocol and Windows authentication
- **Proof of Concept**: Quickly prototype NTLM-based solutions

## 📝 Notes

- This is a **test/development application only**
- Do NOT use in production
- Credentials are stored in plain text for testing purposes
- The NTLM implementation is simplified for testing
- Real applications should integrate with Active Directory

## 🔐 Security Notice

This application is designed for testing only. It:
- Stores credentials in plain text
- Doesn't use HTTPS
- Has no rate limiting or security hardening
- Should never be exposed to the internet

Use only in trusted development environments.

## 📄 License

MIT

## ❓ Additional Resources

- [NTLM Authentication Documentation](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-nlmp/)
- [Express.js Documentation](https://expressjs.com/)
- [express-ntlm Package](https://www.npmjs.com/package/express-ntlm)
