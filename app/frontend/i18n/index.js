import { createI18n } from 'vue-i18n';

// Import translation files
import en from './en.json';
import fr from './fr.json';
import mg from './mg.json';

const messages = { en, fr, mg };

// Create the i18n instance
const i18n = createI18n({
  legacy: false,
  locale: 'en', // default locale
  fallbackLocale: 'en', // fallback locale
  messages, // set locale messages
});

export default i18n;
