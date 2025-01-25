// vite.config.mts
import { defineConfig } from "file:///Users/mtofa/Desktop/job/follow/node_modules/vite/dist/node/index.js";
import RubyPlugin, { projectRoot } from "file:///Users/mtofa/Desktop/job/follow/node_modules/vite-plugin-ruby/dist/index.js";
import vue from "file:///Users/mtofa/Desktop/job/follow/node_modules/@vitejs/plugin-vue/dist/index.mjs";
import tailwindcss from "file:///Users/mtofa/Desktop/job/follow/node_modules/tailwindcss/lib/index.js";
import autoprefixer from "file:///Users/mtofa/Desktop/job/follow/node_modules/autoprefixer/lib/autoprefixer.js";
import VueI18nPlugin from "file:///Users/mtofa/Desktop/job/follow/node_modules/@intlify/unplugin-vue-i18n/lib/vite.mjs";
import { resolve } from "path";
var __vite_injected_original_dirname = "/Users/mtofa/Desktop/job/follow";
var vite_config_default = defineConfig({
  plugins: [
    vue(),
    RubyPlugin(),
    VueI18nPlugin({
      runtimeOnly: true,
      include: [resolve(__vite_injected_original_dirname, "app/frontend/i18n/*.json")]
    })
  ],
  server: {
    watch: {
      usePolling: true
      // Ensures changes are picked up in Docker or VM environments
    }
  },
  resolve: {
    alias: {
      // scss imports require exlicit link to node_modules
      "~": resolve(projectRoot, "node_modules"),
      "@": resolve(__vite_injected_original_dirname, "app/frontend"),
      root: resolve(projectRoot, "./")
    }
  },
  css: {
    postcss: {
      plugins: [
        tailwindcss(),
        autoprefixer()
      ]
    }
  }
});
export {
  vite_config_default as default
};
//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAic291cmNlcyI6IFsidml0ZS5jb25maWcubXRzIl0sCiAgInNvdXJjZXNDb250ZW50IjogWyJjb25zdCBfX3ZpdGVfaW5qZWN0ZWRfb3JpZ2luYWxfZGlybmFtZSA9IFwiL1VzZXJzL210b2ZhL0Rlc2t0b3Avam9iL2ZvbGxvd1wiO2NvbnN0IF9fdml0ZV9pbmplY3RlZF9vcmlnaW5hbF9maWxlbmFtZSA9IFwiL1VzZXJzL210b2ZhL0Rlc2t0b3Avam9iL2ZvbGxvdy92aXRlLmNvbmZpZy5tdHNcIjtjb25zdCBfX3ZpdGVfaW5qZWN0ZWRfb3JpZ2luYWxfaW1wb3J0X21ldGFfdXJsID0gXCJmaWxlOi8vL1VzZXJzL210b2ZhL0Rlc2t0b3Avam9iL2ZvbGxvdy92aXRlLmNvbmZpZy5tdHNcIjtpbXBvcnQgeyBkZWZpbmVDb25maWcgfSBmcm9tICd2aXRlJ1xuaW1wb3J0IFJ1YnlQbHVnaW4sIHsgcHJvamVjdFJvb3QgfSBmcm9tICd2aXRlLXBsdWdpbi1ydWJ5J1xuaW1wb3J0IHZ1ZSBmcm9tICdAdml0ZWpzL3BsdWdpbi12dWUnO1xuaW1wb3J0IHRhaWx3aW5kY3NzIGZyb20gJ3RhaWx3aW5kY3NzJztcbmltcG9ydCBhdXRvcHJlZml4ZXIgZnJvbSAnYXV0b3ByZWZpeGVyJztcbmltcG9ydCBWdWVJMThuUGx1Z2luIGZyb20gJ0BpbnRsaWZ5L3VucGx1Z2luLXZ1ZS1pMThuL3ZpdGUnO1xuaW1wb3J0IHsgcmVzb2x2ZSB9IGZyb20gJ3BhdGgnO1xuXG5cbmV4cG9ydCBkZWZhdWx0IGRlZmluZUNvbmZpZyh7XG4gIHBsdWdpbnM6IFtcbiAgICB2dWUoKSxcbiAgICBSdWJ5UGx1Z2luKCksXG4gICAgVnVlSTE4blBsdWdpbih7XG4gICAgICBydW50aW1lT25seTogdHJ1ZSxcbiAgICAgIGluY2x1ZGU6IFtyZXNvbHZlKF9fZGlybmFtZSwgJ2FwcC9mcm9udGVuZC9pMThuLyouanNvbicpXSxcbiAgICB9KVxuICBdLFxuICBzZXJ2ZXI6IHtcbiAgICB3YXRjaDoge1xuICAgICAgdXNlUG9sbGluZzogdHJ1ZSwgLy8gRW5zdXJlcyBjaGFuZ2VzIGFyZSBwaWNrZWQgdXAgaW4gRG9ja2VyIG9yIFZNIGVudmlyb25tZW50c1xuICAgIH0sXG4gIH0sXG5cbiAgcmVzb2x2ZToge1xuICAgIGFsaWFzOiB7XG4gICAgICAvLyBzY3NzIGltcG9ydHMgcmVxdWlyZSBleGxpY2l0IGxpbmsgdG8gbm9kZV9tb2R1bGVzXG4gICAgICAnfic6IHJlc29sdmUocHJvamVjdFJvb3QsICdub2RlX21vZHVsZXMnKSxcbiAgICAgICdAJzogcmVzb2x2ZShfX2Rpcm5hbWUsICdhcHAvZnJvbnRlbmQnKSxcbiAgICAgIHJvb3Q6IHJlc29sdmUocHJvamVjdFJvb3QsICcuLycpLFxuICAgIH1cbiAgfSxcbiAgY3NzOiB7XG4gICAgcG9zdGNzczoge1xuICAgICAgcGx1Z2luczogW1xuICAgICAgICB0YWlsd2luZGNzcygpLFxuICAgICAgICBhdXRvcHJlZml4ZXIoKSxcbiAgICAgIF0sXG4gICAgfSxcbiAgfSxcbn0pXG4iXSwKICAibWFwcGluZ3MiOiAiO0FBQWlSLFNBQVMsb0JBQW9CO0FBQzlTLE9BQU8sY0FBYyxtQkFBbUI7QUFDeEMsT0FBTyxTQUFTO0FBQ2hCLE9BQU8saUJBQWlCO0FBQ3hCLE9BQU8sa0JBQWtCO0FBQ3pCLE9BQU8sbUJBQW1CO0FBQzFCLFNBQVMsZUFBZTtBQU54QixJQUFNLG1DQUFtQztBQVN6QyxJQUFPLHNCQUFRLGFBQWE7QUFBQSxFQUMxQixTQUFTO0FBQUEsSUFDUCxJQUFJO0FBQUEsSUFDSixXQUFXO0FBQUEsSUFDWCxjQUFjO0FBQUEsTUFDWixhQUFhO0FBQUEsTUFDYixTQUFTLENBQUMsUUFBUSxrQ0FBVywwQkFBMEIsQ0FBQztBQUFBLElBQzFELENBQUM7QUFBQSxFQUNIO0FBQUEsRUFDQSxRQUFRO0FBQUEsSUFDTixPQUFPO0FBQUEsTUFDTCxZQUFZO0FBQUE7QUFBQSxJQUNkO0FBQUEsRUFDRjtBQUFBLEVBRUEsU0FBUztBQUFBLElBQ1AsT0FBTztBQUFBO0FBQUEsTUFFTCxLQUFLLFFBQVEsYUFBYSxjQUFjO0FBQUEsTUFDeEMsS0FBSyxRQUFRLGtDQUFXLGNBQWM7QUFBQSxNQUN0QyxNQUFNLFFBQVEsYUFBYSxJQUFJO0FBQUEsSUFDakM7QUFBQSxFQUNGO0FBQUEsRUFDQSxLQUFLO0FBQUEsSUFDSCxTQUFTO0FBQUEsTUFDUCxTQUFTO0FBQUEsUUFDUCxZQUFZO0FBQUEsUUFDWixhQUFhO0FBQUEsTUFDZjtBQUFBLElBQ0Y7QUFBQSxFQUNGO0FBQ0YsQ0FBQzsiLAogICJuYW1lcyI6IFtdCn0K
