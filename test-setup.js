// Global test setup for BaseInput component tests
import { config } from '@vue/test-utils';
import { vi } from 'vitest';

// Mock vue-i18n
vi.mock('vue-i18n', () => ({
  useI18n: () => ({
    t: (key) => key,
    locale: { value: 'en' },
    availableLocales: ['en', 'fr', 'mg', 'zh-CN']
  }),
  createI18n: () => ({
    install: () => {},
    global: {
      t: (key) => key
    }
  })
}));

// Global configuration for Vue Test Utils
config.global.stubs = {
  // Add any global component stubs here if needed
};

// Mock window functions if needed
global.ResizeObserver = class ResizeObserver {
  observe() {}
  unobserve() {}
  disconnect() {}
};
