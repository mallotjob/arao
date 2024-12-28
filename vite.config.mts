import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue';
import tailwindcss from 'tailwindcss';
import autoprefixer from 'autoprefixer';
import VueI18nPlugin from '@intlify/unplugin-vue-i18n/vite';
import { resolve } from 'path';


export default defineConfig({
  plugins: [
    vue(),
    RubyPlugin(),
    VueI18nPlugin({
      runtimeOnly: true,
      include: [resolve(__dirname, 'app/frontend/i18n/*.json')],
    })
  ],
  server: {
    watch: {
      usePolling: true, // Ensures changes are picked up in Docker or VM environments
    },
  },
  css: {
    postcss: {
      plugins: [
        tailwindcss(),
        autoprefixer(),
      ],
    },
  },
})
