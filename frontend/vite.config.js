import { fileURLToPath, URL } from 'node:url';
import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  server: {
    // Listen on all network interfaces
    host: '0.0.0.0',
    // Use port 5173
    port: 5173,
    // Enable CORS (if needed)
    cors: true,
    // Add headers (if needed, for example for dev proxy settings)
    // headers: {}
  }
});
