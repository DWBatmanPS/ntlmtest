FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application files
COPY server.js config.js ./
COPY public ./public

# Expose port
EXPOSE 3000

# Set environment variables (optional)
ENV PORT=3000
ENV HOST=0.0.0.0
ENV NTLM_DOMAIN=testdomain
ENV NTLM_WORKSTATION=TESTPC

# Start server
CMD ["npm", "start"]
