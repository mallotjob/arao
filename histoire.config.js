import { defineConfig } from 'histoire';
import { HstVue } from '@histoire/plugin-vue';

export default defineConfig({
  plugins: [
    HstVue()
  ],
  setupFile: 'app/frontend/histoire.setup.ts'
});
