# NTLM Test App - Quick Reference Card

## 📍 Server Status
**✅ RUNNING** on http://localhost:3000

---

## 🔑 Test Credentials

```
Domain:   testdomain
Username: user1, user2
Password: password1, password2

Domain:   localhost
Username: admin
Password: admin123
```

Usage format: `domain\username`

---

## 🌐 Web Interface
- **URL**: http://localhost:3000
- **Features**: Check status, test endpoints, view responses

---

## 🛠️ Common Commands

### Start Server
```powershell
npm start
```

### Test with PowerShell
```powershell
.\test-ntlm.ps1
```

### Test with cURL
```bash
curl -i --ntlm -u "testdomain\user1:password1" http://localhost:3000/api/status
```

### Stop Server
```powershell
Ctrl+C
```

### Kill Port
```powershell
npx kill-port 3000
```

---

## 📚 API Endpoints

| Endpoint | Method | Auth Required | Purpose |
|----------|--------|---------------|---------|
| `/` | GET | No | Web UI |
| `/api/status` | GET | No | NTLM info |
| `/api/test-users` | GET | No | List users |
| `/api/protected` | GET | **Yes** | Protected data |

---

## 🔧 Quick Customizations

### Add Test User
Edit `config.js`:
```javascript
'testdomain\\newuser': 'newpassword'
```

### Change Port
Edit `config.js`:
```javascript
port: 5000
```

### Change Domain
Edit `config.js`:
```javascript
domain: 'MYCOMPANY'
```

---

## 📁 Key Files

| File | Purpose |
|------|---------|
| `server.js` | Main application |
| `config.js` | Settings & users |
| `public/index.html` | Web UI |
| `test-ntlm.ps1` | Test script |

---

## 📖 Documentation

| Document | Purpose |
|----------|---------|
| `INDEX.md` | Documentation guide |
| `SETUP_SUMMARY.md` | Project overview |
| `QUICKSTART.md` | Getting started |
| `README.md` | Full documentation |
| `ADVANCED.md` | Advanced topics |

---

## 🚀 Docker

```bash
docker-compose up
```

---

## ✨ Features

✓ No Active Directory required  
✓ Mock user database  
✓ Web dashboard  
✓ REST API  
✓ PowerShell testing  
✓ Docker support  
✓ Lightweight  
✓ Customizable  

---

## 💡 Quick Tips

1. **First time?** → Open http://localhost:3000
2. **Need help?** → Read INDEX.md
3. **Test users?** → Run `.\test-ntlm.ps1`
4. **Customize?** → Edit config.js
5. **Troubleshoot?** → Check README.md

---

## 🎯 Your App is Ready!

Everything is installed and running. Start exploring! 🎉
