# Use an official Node runtime as a parent image
FROM node:lts

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install any needed packages specified in package.json
RUN npm install

# Copy the rest of the codebase into the container
COPY . .

# Expose the port the app runs on
EXPOSE 5173

# Start the app using npm run dev
CMD ["npm", "run", "dev"]
