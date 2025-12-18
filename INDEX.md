# NTLM Test Application - Documentation Index

Welcome to your NTLM Authentication Test Application! This index helps you navigate all available documentation.

## 🎯 Start Here

**New to this application?** Start with one of these:

1. **[SETUP_SUMMARY.md](SETUP_SUMMARY.md)** ⭐ - Overview of what was created (5 min read)
2. **[QUICKSTART.md](QUICKSTART.md)** - Get up and running (10 min read)
3. **[README.md](README.md)** - Complete documentation (20 min read)

---

## 📚 Documentation Files

### Essential Documentation

| Document | Purpose | Read Time |
|----------|---------|-----------|
| [SETUP_SUMMARY.md](SETUP_SUMMARY.md) | Project overview and what's included | 5 min |
| [QUICKSTART.md](QUICKSTART.md) | Getting started and common tasks | 10 min |
| [README.md](README.md) | Complete reference documentation | 20 min |
| [ADVANCED.md](ADVANCED.md) | Advanced configuration and integration | 15 min |

---

## 🎓 Learning Path

### Beginner
1. Read SETUP_SUMMARY.md for overview
2. Go to http://localhost:3000 in browser
3. Click buttons to test API
4. Read QUICKSTART.md

### Intermediate
1. Review README.md API documentation
2. Test with PowerShell: `.\test-ntlm.ps1`
3. Test with cURL commands
4. Customize config.js (add users, change port)

### Advanced
1. Read ADVANCED.md for advanced patterns
2. Add custom endpoints to server.js
3. Implement role-based access control
4. Deploy with Docker

---

## 🚀 Quick Links

### Running the Application
- **Start server**: `npm start`
- **Development mode**: `npm run dev`
- **Open web UI**: http://localhost:3000
- **Test with PowerShell**: `.\test-ntlm.ps1`

### Key Files to Modify

| File | Purpose | When to Edit |
|------|---------|--------------|
| config.js | Add users, change domain | Customizing test users |
| server.js | Add endpoints, modify auth | Adding new features |
| public/index.html | Modify UI | Customizing dashboard |

### API Testing

```bash
# Check status
curl -i --ntlm -u "testdomain\user1:password1" http://localhost:3000/api/status

# Access protected resource
curl -i --ntlm -u "testdomain\user1:password1" http://localhost:3000/api/protected

# List test users
curl http://localhost:3000/api/test-users
```

---

## 🔍 Find What You Need

### "I want to..."

#### Get Started Quickly
→ [QUICKSTART.md](QUICKSTART.md)

#### Understand How It Works
→ [README.md](README.md) - Architecture section

#### Change Test Users
→ [QUICKSTART.md](QUICKSTART.md) - Customization section
→ [config.js](config.js) - Edit `mockUsers`

#### Change Port Number
→ [QUICKSTART.md](QUICKSTART.md) - Customization section
→ [config.js](config.js) - Edit `port`

#### Add a New API Endpoint
→ [ADVANCED.md](ADVANCED.md) - Integration Examples section
→ [server.js](server.js) - Add route before `app.listen()`

#### Test with Different Tools
→ [QUICKSTART.md](QUICKSTART.md) - Testing Instructions section

#### Deploy with Docker
→ [README.md](README.md) - Deployment section
→ Run: `docker-compose up`

#### Implement Role-Based Access
→ [ADVANCED.md](ADVANCED.md) - Enhanced Authentication section

#### Add Logging and Monitoring
→ [ADVANCED.md](ADVANCED.md) - Logging and Monitoring section

#### Fix a Problem
→ [README.md](README.md) - Troubleshooting section

---

## 📋 File Structure Reference

```
ntlmtest/
│
├── 📄 SETUP_SUMMARY.md     ← Start here! Overview of everything
├── 📄 QUICKSTART.md        ← Quick start and common tasks
├── 📄 README.md            ← Full documentation
├── 📄 ADVANCED.md          ← Advanced configuration
├── 📄 INDEX.md             ← This file
│
├── 🔧 Configuration
│   ├── config.js           ← Customize users, domain, port
│   ├── package.json        ← Dependencies
│   ├── Dockerfile          ← Container configuration
│   └── docker-compose.yml  ← Docker Compose setup
│
├── 💻 Application Code
│   ├── server.js           ← Express server (main code)
│   ├── public/index.html   ← Web dashboard UI
│   └── public/             ← Static files
│
├── 🧪 Testing
│   └── test-ntlm.ps1       ← PowerShell test script
│
└── 📦 Dependencies
    ├── node_modules/       ← Installed packages
    └── package-lock.json   ← Dependency lock file
```

---

## 💡 Common Questions

### Q: Where do I add test users?
**A:** Edit [config.js](config.js), modify the `mockUsers` object

### Q: How do I change the port?
**A:** Edit [config.js](config.js), change the `port` value

### Q: Can I test without Active Directory?
**A:** Yes! That's the whole point. Uses mock user database in [config.js](config.js)

### Q: How do I test from another computer?
**A:** Edit [config.js](config.js), change `host` to `0.0.0.0` and access from IP

### Q: Where's the API reference?
**A:** See [README.md](README.md) - API Endpoints section

### Q: How do I deploy this?
**A:** Use Docker: `docker-compose up` or see [README.md](README.md) - Deployment section

### Q: Can I add more endpoints?
**A:** Yes! Edit [server.js](server.js) and [ADVANCED.md](ADVANCED.md) has examples

### Q: How do I implement HTTPS?
**A:** See [ADVANCED.md](ADVANCED.md) - HTTPS Support section

---

## 🎯 By Use Case

### For Development Teams
- [QUICKSTART.md](QUICKSTART.md) - Get everyone started
- [README.md](README.md) - Full reference
- [ADVANCED.md](ADVANCED.md) - Integration patterns

### For Learning NTLM
- [README.md](README.md) - How It Works section
- [ADVANCED.md](ADVANCED.md) - Complete examples
- [server.js](server.js) - See implementation

### For Testing Applications
- [QUICKSTART.md](QUICKSTART.md) - Testing Instructions
- [test-ntlm.ps1](test-ntlm.ps1) - Automation script
- [config.js](config.js) - Customize test users

### For Production Deployment
- [ADVANCED.md](ADVANCED.md) - Security Hardening
- [docker-compose.yml](docker-compose.yml) - Docker setup
- [Dockerfile](Dockerfile) - Container image

---

## 📞 Support Resources

### In the Documentation
- **Troubleshooting** → [README.md](README.md)
- **API Reference** → [README.md](README.md)
- **Configuration Options** → [QUICKSTART.md](QUICKSTART.md)
- **Code Examples** → [ADVANCED.md](ADVANCED.md)

### In the Code
- **server.js** - Heavily commented, easy to understand
- **config.js** - Simple key-value configuration
- **public/index.html** - Interactive testing UI

---

## ✅ Quick Setup Checklist

- [ ] Read [SETUP_SUMMARY.md](SETUP_SUMMARY.md)
- [ ] Visit http://localhost:3000
- [ ] Click "Check NTLM Status"
- [ ] Run `.\test-ntlm.ps1`
- [ ] Review [QUICKSTART.md](QUICKSTART.md)
- [ ] Customize [config.js](config.js) if needed
- [ ] Bookmark [README.md](README.md) for reference

---

## 🎉 You're Ready!

Everything is set up and running. Pick a documentation file above and dive in!

**First time?** Start with [SETUP_SUMMARY.md](SETUP_SUMMARY.md)  
**Want to get going?** Go to [QUICKSTART.md](QUICKSTART.md)  
**Need details?** See [README.md](README.md)  
**Doing something advanced?** Check [ADVANCED.md](ADVANCED.md)  

Happy testing! 🚀
