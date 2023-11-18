# Benutze node base image
FROM node:20-alpine

# Adde alles zum Image (auser files und folder aus .dockerignore)
ADD . /app

# Copy dotfile
COPY .env.development /app

# Setze workdir
WORKDIR /app

# Install dependencies und build app
RUN npm install --production

# Starte react app auf localhost
CMD ["npm", "start"]
