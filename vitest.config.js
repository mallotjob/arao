import { defineConfig } from 'vitest/config';
import { resolve } from 'path';
import vue from '@vitejs/plugin-vue';

export default defineConfig({
  plugins: [
    vue({
      script: {
        defineModel: true
      }
    })
  ],
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./test-setup.js'],
    include: ['./test/**/*.{spec,test}.{js,mjs,cjs,ts,mts,cts,jsx,tsx}']
  },
  resolve: {
    alias: {
      '@': resolve(__dirname, 'app/frontend')
    }
  },
});
