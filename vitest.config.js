import { defineConfig } from 'vitest/config';
import { resolve } from 'path';
import vue from '@vitejs/plugin-vue';
import VueI18nPlugin from '@intlify/unplugin-vue-i18n/vite';

export default defineConfig({
  plugins: [
    vue({
      script: {
        defineModel: true,
      },
    }),
    VueI18nPlugin({
      runtimeOnly: false,
      include: [resolve(__dirname, 'app/frontend/**/*.{json,yaml,yml}')]
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
      '@': resolve(__dirname, 'app/frontend'),
    },
  },
});
