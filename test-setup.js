// Global test setup for BaseInput component tests
import { config } from '@vue/test-utils';
import { createI18n } from 'vue-i18n';

// Create real i18n instance
const i18n = createI18n({
  locale: 'en',
  fallbackLocale: 'en',
  messages: {}
});

config.global.plugins.push([i18n]);

// Global configuration for Vue Test Utils
config.global.stubs = {
  FontAwesomeIcon: {
    template: '<span class="fa-icon"></span>'
  }
};

// Mock tooltip directive
config.global.directives = {
  tooltip: {}
};

// Mock window functions if needed
global.ResizeObserver = class ResizeObserver {
  observe() {}
  unobserve() {}
  disconnect() {}
};
