# Stage 1: Build the Vue.js application
FROM node:lts as build-stage

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project files and folders to the current working directory
COPY . .

# Build app for production with minification
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:stable-alpine as production-stage

# Copy the built app to Nginx's serve directory
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose port 80 to the outside once the container has launched
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
