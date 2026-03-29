// Global test setup for BaseInput component tests
import { config } from '@vue/test-utils';

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
