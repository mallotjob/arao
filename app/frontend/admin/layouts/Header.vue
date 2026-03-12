<template>
  <header class="bg-white dark:bg-slate-800 shadow-sm border-b border-slate-200 dark:border-slate-700">
    <div class="flex items-center justify-between h-16 px-4 sm:px-6 lg:px-8">
      <button
        class="lg:hidden p-2 rounded-md text-slate-400 dark:text-slate-300 hover:text-slate-500
      dark:hover:text-white hover:bg-slate-100 dark:hover:bg-slate-700"
        @click="toggleSidebar"
      >
        <FontAwesomeIcon
          :icon="['fas', 'bars']"
          class="h-6 w-6"
        />
      </button>

      <div class="flex items-center ml-auto space-x-4">
        <!-- Theme toggle -->
        <button
          class="flex items-center justify-center p-2 rounded bg-gray-200 dark:bg-gray-700 hover:bg-gray-300
        dark:hover:bg-gray-600"
          @click="toggleTheme"
        >
          <FontAwesomeIcon
            :icon="isDark ? ['fas','sun'] : ['fas','moon']"
            class="text-slate-600 dark:text-slate-300"
          />
        </button>

        <!-- Language -->
        <div class="relative">
          <button
            class="flex items-center space-x-2 p-2 rounded-md text-slate-400 dark:text-slate-300
          hover:text-slate-500 dark:hover:text-white hover:bg-slate-100 dark:hover:bg-slate-700"
            @click="showLanguageMenu = !showLanguageMenu; showUserMenu = false"
          >
            <FontAwesomeIcon :icon="['fas','globe']" />
            <span class="hidden sm:block text-sm font-medium">{{ currentLanguage() }}</span>
            <FontAwesomeIcon :icon="['fas','chevron-down']" />
          </button>

          <!-- Language Dropdown -->
          <div
            v-if="showLanguageMenu"
            class="absolute right-0 mt-2 w-48 bg-white dark:bg-slate-800 rounded-lg
        shadow-lg border border-slate-200 dark:border-slate-700 z-50"
          >
            <div class="py-1">
              <button
                v-for="lang in languages"
                :key="lang.code"
                class="flex items-center w-full px-4 py-2 text-sm text-slate-700 dark:text-slate-300
              hover:bg-slate-50 dark:hover:bg-slate-700"
                @click="changeLanguage(lang.code)"
              >
                <span class="mr-3">{{ lang.flag }}</span>{{ lang.name }}
              </button>
            </div>
          </div>
        </div>

        <!-- User Menu -->
        <div class="relative">
          <button
            class="flex items-center space-x-3 p-2 rounded-md text-slate-400 dark:text-slate-300
          hover:text-slate-500 dark:hover:text-white hover:bg-slate-100 dark:hover:bg-slate-700"
            @click="showUserMenu = !showUserMenu; showLanguageMenu = false"
          >
            <div class="w-8 h-8 bg-blue-500 rounded-full flex items-center justify-center">
              <span class="text-sm font-medium text-white">{{ userInitials }}</span>
            </div>
            <FontAwesomeIcon :icon="['fas','chevron-down']" />
          </button>

          <div
            v-if="showUserMenu"
            class="absolute right-0 mt-2 w-48 bg-white dark:bg-slate-800 rounded-lg shadow-lg
        border border-slate-200 dark:border-slate-700 z-50"
          >
            <div class="py-1">
              <router-link
                :to="{ name: 'account' }"
                class="block px-4 py-2 text-sm text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-700"
              >
                {{ t('account_settings') }}
              </router-link>
              <button
                class="block w-full text-left px-4 py-2 text-sm text-slate-700 dark:text-slate-300
            hover:bg-slate-50 dark:hover:bg-slate-700"
                @click="handleLogout"
              >
                {{ t('sign_out') }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
</template>
<script setup>
import { computed, onMounted, onUnmounted, ref } from 'vue';
import { useI18n } from 'vue-i18n';
import api from '@/admin/api';

const { t, locale } = useI18n();
const emit = defineEmits(['toggle-sidebar']);

const currentUser = ref({
  email: 'admin@example.com',
  first_name: 'Admin',
  last_name: 'User'
});
const showUserMenu = ref(false);
const isDark = ref(false);
const showLanguageMenu = ref(false);

const changeLanguage = (newLocale) => {
  locale.value = newLocale;
  localStorage.setItem('locale', newLocale);
  showLanguageMenu.value = false;
};

const handleLogout = async () => {
  await api.logOut();
  window.location.href = '/users/sign_out';
};

const languages = [
  { code: 'en', name: 'English', flag: '🇺🇸' },
  { code: 'fr', name: 'Français', flag: '🇫🇷' },
  { code: 'mg', name: 'Malagasy', flag: '🇲🇬' },
  { code: 'zh-CN', name: '中文', flag: '🇨🇳' },
];


const userInitials = computed(() => {
  const user = currentUser.value;
  return `${user.first_name?.[0] || ''}${user.last_name?.[0] || ''}`.toUpperCase();
});

const currentLanguage = () => {
  const lang = languages.find(l => l.code === (localStorage.getItem('locale') || 'en'));
  return lang ? lang.name : 'English';
};

const toggleTheme = () => {
  isDark.value = !isDark.value;

  if (isDark.value) {
    document.documentElement.classList.add('dark');
    localStorage.setItem('theme', 'dark');
  } else {
    document.documentElement.classList.remove('dark');
    localStorage.setItem('theme', 'light');
  }
};

const handleClickOutside = (event) => {
  if (!event.target.closest('.relative')) {
    showLanguageMenu.value = false;
    showUserMenu.value = false;
  }
};

const toggleSidebar = () => {
  emit('toggle-sidebar');
};

onMounted(() => {
  document.addEventListener('click', handleClickOutside);

  const savedTheme = localStorage.getItem('theme');
  const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

  if (savedTheme === 'dark' || (!savedTheme && prefersDark)) {
    document.documentElement.classList.add('dark');
    isDark.value = true;
  }
});

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside);
});
</script>
<i18n lang="yaml">
  en:
    account_settings: Account Settings
    sign_out: Sign Out
  fr:
    account_settings: Paramètres du compte
    sign_out: Se déconnecter
  mg:
    account_settings: Kaonty
    sign_out: Hiala
  zh-CN:
    account_settings: 账户设置
    sign_out: 退出登录
</i18n>
