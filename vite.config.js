import { defineConfig } from 'vite';
import { resolve } from 'path';
import autoprefixer from 'autoprefixer';
import RubyPlugin, { projectRoot } from 'vite-plugin-ruby';
import tailwindcss from 'tailwindcss';
import vue from '@vitejs/plugin-vue';
import VueI18nPlugin from '@intlify/unplugin-vue-i18n/vite';

const isTesting = process.env.HISTOIRE || process.env.VITEST;

export default defineConfig({
  plugins: [
    vue(),
    !isTesting ? RubyPlugin() : null,
    VueI18nPlugin({
      runtimeOnly: true,
      include: [resolve(__dirname, 'app/frontend/i18n/*.json')],
    })
  ],
  server: {
    watch: {
      ignored: ['**/node_modules/**', '**/tmp/**'], // Ignore unnecessary files
    },
    hmr: true,
  },

  resolve: {
    alias: {
      // scss imports require exlicit link to node_modules
      '~': resolve(projectRoot, 'node_modules'),
      '@': resolve(__dirname, 'app/frontend'),
      root: resolve(projectRoot, './'),
    }
  },
  css: {
    postcss: {
      plugins: [
        tailwindcss(),
        autoprefixer(),
      ],
    },
  },
});
