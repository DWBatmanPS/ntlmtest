# NTLM Test App - Advanced Usage Guide

## 🔧 Advanced Configuration

### Custom Domain and Workstation

Modify `config.js` to match your organization:

```javascript
export const serverConfig = {
  port: 3000,
  host: 'localhost',
  ntlm: {
    domain: 'MYCOMPANY',        // Your domain name
    workstation: 'TESTSERVER'   // Your workstation name
  }
};
```

### Multiple Domains

Add users from different domains:

```javascript
export const mockUsers = {
  'company\\user1': 'pass1',
  'company\\admin': 'adminpass',
  'partner\\user2': 'pass2',
  'localhost\\testuser': 'testpass',
  'ad\\serviceaccount': 'svcpass'
};
```

---

## 🔐 Enhanced Authentication

### Custom User Validation Logic

Modify `authenticateNTLMUser` in `server.js` to implement complex validation:

```javascript
const authenticateNTLMUser = (req, res, next) => {
  const username = req.ntlm?.UserName;
  const domain = req.ntlm?.DomainName;
  const userKey = `${domain}\\${username}`.toLowerCase();
  
  // Custom logic examples:
  
  // 1. Role-based access
  const adminUsers = ['testdomain\\admin', 'company\\administrator'];
  if (adminUsers.includes(userKey)) {
    req.user.role = 'admin';
  }
  
  // 2. Department-based access
  const engineeringDomains = ['company', 'engineering'];
  if (engineeringDomains.includes(domain?.toLowerCase())) {
    req.user.department = 'Engineering';
  }
  
  // 3. Time-based restrictions
  const now = new Date().getHours();
  if (now < 8 || now > 17) {
    return res.status(403).json({ error: 'Access only during business hours' });
  }
  
  next();
};
```

### IP-Based Access Control

Add to `server.js` to restrict by IP:

```javascript
const allowedIPs = ['127.0.0.1', '192.168.1.100', '::1'];

const checkIP = (req, res, next) => {
  const clientIP = req.ip;
  if (!allowedIPs.includes(clientIP)) {
    return res.status(403).json({ error: 'IP not allowed', clientIP });
  }
  next();
};

// Add middleware to protected routes
app.get('/api/protected', checkIP, authenticateNTLMUser, (req, res) => {
  // ...
});
```

---

## 📊 Logging and Monitoring

### Detailed Request Logging

Add to `server.js` for auditing:

```javascript
const requestLogger = (req, res, next) => {
  const timestamp = new Date().toISOString();
  const ntlmUser = req.ntlm?.UserName || 'anonymous';
  const method = req.method;
  const path = req.path;
  
  console.log(`[${timestamp}] ${method} ${path} - User: ${ntlmUser}`);
  
  // Log response
  res.on('finish', () => {
    console.log(`  └─ Status: ${res.statusCode}`);
  });
  
  next();
};

app.use(requestLogger);
```

### Audit Trail Endpoint

Add an audit trail in `server.js`:

```javascript
const auditLog = [];

app.get('/api/audit', authenticateNTLMUser, (req, res) => {
  // Only admins can view audit log
  if (!isAdmin(req.user.username)) {
    return res.status(403).json({ error: 'Admin access required' });
  }
  res.json(auditLog);
});

// Log all authentication attempts
app.use((req, res, next) => {
  if (req.ntlm?.UserName) {
    auditLog.push({
      timestamp: new Date().toISOString(),
      username: req.ntlm.UserName,
      domain: req.ntlm.DomainName,
      endpoint: req.path,
      method: req.method,
      status: res.statusCode
    });
  }
  next();
});
```

---

## 🌐 Network and Deployment

### Allow Remote Connections

Change host in `config.js`:

```javascript
export const serverConfig = {
  port: 3000,
  host: '0.0.0.0',  // Listen on all interfaces
  ntlm: {
    domain: 'testdomain',
    workstation: 'TESTPC'
  }
};
```

Then access from another machine:
```bash
curl --ntlm -u "testdomain\user1:password1" http://192.168.1.100:3000/api/status
```

### HTTPS Support

Add HTTPS:

```javascript
import https from 'https';
import fs from 'fs';

// Generate self-signed cert or use existing one
const options = {
  key: fs.readFileSync('key.pem'),
  cert: fs.readFileSync('cert.pem')
};

https.createServer(options, app).listen(443, () => {
  console.log('HTTPS server running on port 443');
});
```

Generate self-signed certificate:
```bash
openssl req -nodes -new -x509 -keyout key.pem -out cert.pem -days 365
```

---

## 🧬 Integration Examples

### Express Middleware for Protected Routes

Create `ntlm-middleware.js`:

```javascript
export const requireNTLM = (req, res, next) => {
  if (!req.ntlm?.UserName) {
    return res.status(401).json({ error: 'NTLM authentication required' });
  }
  next();
};

export const requireAdmin = (req, res, next) => {
  const adminUsers = ['testdomain\\admin', 'company\\administrator'];
  const userKey = `${req.ntlm.DomainName}\\${req.ntlm.UserName}`.toLowerCase();
  
  if (!adminUsers.includes(userKey)) {
    return res.status(403).json({ error: 'Admin access required' });
  }
  next();
};

// Usage in server.js
import { requireNTLM, requireAdmin } from './ntlm-middleware.js';

app.get('/api/admin-panel', requireAdmin, (req, res) => {
  res.json({ message: 'Admin panel data' });
});
```

### Session Management

Add session support:

```javascript
import session from 'express-session';

app.use(session({
  secret: 'your-secret-key',
  resave: false,
  saveUninitialized: true,
  cookie: { 
    secure: false,  // Set to true if using HTTPS
    httpOnly: true,
    maxAge: 3600000  // 1 hour
  }
}));

// Store NTLM info in session
app.use((req, res, next) => {
  if (req.ntlm?.UserName && !req.session.user) {
    req.session.user = {
      username: req.ntlm.UserName,
      domain: req.ntlm.DomainName,
      loginTime: new Date()
    };
  }
  next();
});
```

---

## 📈 Performance Optimization

### Caching NTLM Responses

Add caching layer:

```javascript
const userCache = new Map();

const getCachedUser = (key) => {
  if (!userCache.has(key)) return null;
  
  const cached = userCache.get(key);
  if (Date.now() - cached.timestamp > 5 * 60 * 1000) {  // 5 minute TTL
    userCache.delete(key);
    return null;
  }
  
  return cached.data;
};

const authenticateWithCache = (req, res, next) => {
  const userKey = `${req.ntlm?.DomainName}\\${req.ntlm?.UserName}`;
  const cached = getCachedUser(userKey);
  
  if (cached) {
    req.user = cached;
    return next();
  }
  
  // Perform auth and cache
  authenticateNTLMUser(req, res, () => {
    userCache.set(userKey, {
      data: req.user,
      timestamp: Date.now()
    });
    next();
  });
};
```

### Rate Limiting

Add rate limiting:

```javascript
import rateLimit from 'express-rate-limit';

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,  // 15 minutes
  max: 100,                   // limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP'
});

app.use('/api/', limiter);
```

---

## 🧪 Testing Scenarios

### Simulating Failed Authentication

Create test endpoints:

```javascript
app.get('/api/test/fail-auth', (req, res) => {
  res.status(401).json({
    error: 'Authentication failed',
    reason: 'Invalid NTLM credentials',
    timestamp: new Date().toISOString()
  });
});

app.get('/api/test/fail-authz', authenticateNTLMUser, (req, res) => {
  res.status(403).json({
    error: 'Authorization failed',
    reason: 'User lacks required permissions',
    user: req.user
  });
});
```

### Load Testing

Use Apache Bench or loadtest:

```bash
# Install loadtest
npm install -g loadtest

# Run load test
loadtest -n 1000 -c 10 --ntlm --username testdomain\\user1 --password password1 http://localhost:3000/api/status
```

---

## 🔧 Environment Variables

Support environment configuration:

```javascript
export const serverConfig = {
  port: process.env.PORT || 3000,
  host: process.env.HOST || 'localhost',
  ntlm: {
    domain: process.env.NTLM_DOMAIN || 'testdomain',
    workstation: process.env.NTLM_WORKSTATION || 'TESTPC'
  }
};
```

Create `.env` file:
```
PORT=3000
HOST=localhost
NTLM_DOMAIN=mycompany
NTLM_WORKSTATION=TESTSERVER
```

Load with:
```bash
npm install dotenv
```

```javascript
import dotenv from 'dotenv';
dotenv.config();
```

---

## 📝 Logging to File

Add file logging:

```javascript
import fs from 'fs';
import path from 'path';

const logStream = fs.createWriteStream(
  path.join('logs', 'app.log'),
  { flags: 'a' }
);

const fileLogger = (req, res, next) => {
  const timestamp = new Date().toISOString();
  const log = `[${timestamp}] ${req.method} ${req.path} - ${req.ntlm?.UserName || 'anonymous'}\n`;
  logStream.write(log);
  next();
};

app.use(fileLogger);
```

---

## 🔒 Security Hardening

### Implement Security Headers

```javascript
app.use((req, res, next) => {
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('X-Frame-Options', 'DENY');
  res.setHeader('X-XSS-Protection', '1; mode=block');
  res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');
  next();
});
```

### CORS Configuration

```javascript
import cors from 'cors';

const corsOptions = {
  origin: ['http://localhost:3000', 'http://trusted-domain.com'],
  credentials: true
};

app.use(cors(corsOptions));
```

---

## 📚 Additional Resources

- [NTLM Protocol Specification](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-nlmp/)
- [Express.js Security Best Practices](https://expressjs.com/en/advanced/best-practice-security.html)
- [OWASP Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)
- [express-ntlm Documentation](https://github.com/einfallstoll/express-ntlm)

---

## 💡 Tips and Tricks

1. **Debug Mode**: Add `console.log()` statements in middleware to trace requests
2. **Test Different Domains**: Use multiple test users from different domains
3. **Postman**: Use Postman with NTLM auth for API testing
4. **Docker**: Containerize the app for consistent testing environments
5. **CI/CD**: Integrate tests into your pipeline for automated validation

---

For more information, see:
- [README.md](README.md) - Full documentation
- [QUICKSTART.md](QUICKSTART.md) - Quick start guide
