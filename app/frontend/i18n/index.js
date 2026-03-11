import { createI18n } from 'vue-i18n';

// Import translation files
import en from './en.json';
import fr from './fr.json';
import mg from './mg.json';
import zhCN from './zh-CN.json';

const messages = { en, fr, mg, 'zh-CN': zhCN };
const savedLocale = localStorage.getItem('locale') || 'en';

// Create the i18n instance
const i18n = createI18n({
  legacy: false,
  locale: savedLocale, // default locale
  fallbackLocale: 'en', // fallback locale
  messages, // set locale messages
});

export default i18n;
