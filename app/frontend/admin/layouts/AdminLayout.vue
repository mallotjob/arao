<template>
  <div class="min-h-screen bg-slate-50">
    <!-- Sidebar -->
    <div
      :class="[
        'fixed inset-y-0 left-0 z-50 w-64 bg-slate-900 transform transition-transform duration-300 ease-in-out '
          + 'lg:translate-x-0 lg:static lg:inset-0',
        sidebarOpen ? 'translate-x-0' : '-translate-x-full'
      ]"
    >
      <!-- Logo -->
      <div class="flex items-center h-16 px-6 bg-slate-800">
        <div class="flex items-center">
          <div class="w-8 h-8 bg-blue-500 rounded-lg flex items-center justify-center">
            <svg
              class="w-5 h-5 text-white"
              fill="currentColor"
              viewBox="0 0 20 20"
            >
              <path
                d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0
              001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"
              />
            </svg>
          </div>
          <span class="ml-3 text-xl font-semibold text-white">Follow Admin</span>
        </div>
      </div>

      <!-- Navigation -->
      <nav class="mt-6 px-3">
        <div class="space-y-1">
          <!-- <router-link
            v-for="item in navigation"
            :key="item.name"
            :to="{ name: item.route }"
            class="group flex items-center px-3 py-2 text-sm font-medium rounded-md transition-colors"
            :class="[
              $route.name === item.route
                ? 'bg-slate-800 text-white'
                : 'text-slate-300 hover:bg-slate-700 hover:text-white'
            ]"
          >
            <component :is="item.icon" class="mr-3 h-5 w-5" />
            {{ item.name }}
          </router-link> -->
        </div>

        <!-- Management Section -->
        <div class="mt-8">
          <h3 class="px-3 text-xs font-semibold text-slate-400 uppercase tracking-wider">
            Management
          </h3>
          <div
            v-for="item in managementNav"
            :key="item.name"
            class="mt-3 space-y-1"
          >
            {{ item.route }}
            <!-- <router-link
              :to="{ name: item.route }"
              class="group flex items-center px-3 py-2 text-sm font-medium rounded-md transition-colors"
              :class="[
                $route.name === item.route
                  ? 'bg-slate-800 text-white'
                  : 'text-slate-300 hover:bg-slate-700 hover:text-white'
              ]"
              v-if="canAccess(item.permission)"
            >
              <component :is="item.icon" class="mr-3 h-5 w-5" />
              {{ item.name }}
            </router-link> -->
          </div>
        </div>
      </nav>
    </div>

    <!-- Main Content -->
    <div class="lg:pl-64">
      <!-- Top Navigation -->
      <header class="bg-white shadow-sm border-b border-slate-200">
        <div class="flex items-center justify-between h-16 px-4 sm:px-6 lg:px-8">
          <!-- Mobile menu button -->
          <button
            class="lg:hidden p-2 rounded-md text-slate-400 hover:text-slate-500 hover:bg-slate-100
            focus:outline-none focus:ring-2 focus:ring-inset focus:ring-blue-500"
            @click="toggleSidebar"
          >
            <Bars3Icon class="h-6 w-6" />
          </button>

          <!-- Right side items -->
          <div class="flex items-center space-x-4">
            <!-- Language Selector -->
            <div class="relative">
              <button
                class="flex items-center space-x-2 p-2 rounded-md text-slate-400 hover:text-slate-500 hover:bg-slate-100"
                @click="showLanguageMenu = !showLanguageMenu"
              >
                <GlobeAltIcon class="h-5 w-5" />
                <span class="hidden sm:block text-sm font-medium">{{ currentLanguage }}</span>
                <ChevronDownIcon class="h-4 w-4" />
              </button>

              <!-- Language Dropdown -->
              <div
                v-if="showLanguageMenu"
                class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg border border-slate-200 z-50"
              >
                <div class="py-1">
                  <button
                    v-for="lang in languages"
                    :key="lang.code"
                    class="flex items-center w-full px-4 py-2 text-sm text-slate-700 hover:bg-slate-50"
                    @click="changeLanguage(lang.code)"
                  >
                    <span class="mr-3">{{ lang.flag }}</span>
                    {{ lang.name }}
                  </button>
                </div>
              </div>
            </div>

            <!-- User Menu -->
            <div class="relative">
              <button
                class="flex items-center space-x-3 p-2 rounded-md text-slate-400 hover:text-slate-500 hover:bg-slate-100"
                @click="showUserMenu = !showUserMenu"
              >
                <div class="w-8 h-8 bg-blue-500 rounded-full flex items-center justify-center">
                  <span class="text-sm font-medium text-white">{{ userInitials }}</span>
                </div>
                <ChevronDownIcon class="h-4 w-4" />
              </button>

              <!-- User Dropdown -->
              <div
                v-if="showUserMenu"
                class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg border border-slate-200 z-50"
              >
                <div class="py-1">
                  <router-link
                    :to="{ name: 'account' }"
                    class="block px-4 py-2 text-sm text-slate-700 hover:bg-slate-50"
                  >
                    Account Settings
                  </router-link>
                  <button
                    class="block w-full text-left px-4 py-2 text-sm text-slate-700 hover:bg-slate-50"
                    @click="handleLogout"
                  >
                    Sign Out
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </header>

      <!-- Page Content -->
      <main class="p-4 sm:p-6 lg:p-8">
        <router-view />
      </main>
    </div>

    <!-- Mobile sidebar overlay -->
    <div
      v-if="sidebarOpen"
      class="fixed inset-0 bg-slate-600 bg-opacity-75 z-40 lg:hidden"
      @click="toggleSidebar"
    />
  </div>
</template>

<script setup>
import { computed, onMounted, onUnmounted, ref } from 'vue';
// import { useRouter } from 'vue-router'
import {
  Bars3Icon,
  BuildingOfficeIcon,
  ChartBarIcon,
  ChevronDownIcon,
  Cog6ToothIcon,
  CubeIcon,
  GlobeAltIcon,
  // HomeIcon,
  TruckIcon,
  // UserIcon,
  UsersIcon
} from '@heroicons/vue/24/outline';
import api from '@/admin/api';

// const router = useRouter()
const sidebarOpen = ref(false);
const showLanguageMenu = ref(false);
const showUserMenu = ref(false);

// User data (this would come from your auth state)
const currentUser = ref({
  email: 'admin@example.com',
  first_name: 'Admin',
  last_name: 'User'
});

// Navigation items
// const navigation = [
//   { name: 'Dashboard', route: 'home', icon: HomeIcon },
//   { name: 'Account', route: 'account', icon: UserIcon },
// ];

const managementNav = [
  { name: 'Companies', route: 'companies', icon: BuildingOfficeIcon, permission: 'manage_companies' },
  { name: 'Users', route: 'users', icon: UsersIcon, permission: 'manage_users' },
  { name: 'Products', route: 'products', icon: CubeIcon, permission: 'manage_products' },
  { name: 'Shipping', route: 'shipping', icon: TruckIcon, permission: 'manage_shipping' },
  { name: 'Reports', route: 'reports', icon: ChartBarIcon, permission: 'view_reports' },
  { name: 'Settings', route: 'settings', icon: Cog6ToothIcon, permission: 'manage_settings' },
];

// Languages
const languages = [
  { code: 'en', name: 'English', flag: '🇺🇸' },
  { code: 'fr', name: 'Français', flag: '🇫🇷' },
  { code: 'mg', name: 'Malagasy', flag: '🇲🇬' },
  { code: 'zh-CN', name: '中文', flag: '🇨🇳' },
];

const currentLanguage = computed(() => {
  const lang = languages.find(l => l.code === (localStorage.getItem('locale') || 'en'));
  return lang ? lang.name : 'English';
});

const userInitials = computed(() => {
  const user = currentUser.value;
  return `${user.first_name?.[0] || ''}${user.last_name?.[0] || ''}`.toUpperCase();
});

// Methods
const toggleSidebar = () => {
  sidebarOpen.value = !sidebarOpen.value;
};

// const canAccess = (permission) => {
//   // This would integrate with your CASL permissions
//   // For now, return true (admin has all permissions)
//   return true;
// };

const changeLanguage = (locale) => {
  localStorage.setItem('locale', locale);
  // Reload the page with new locale
  window.location.href = `/${locale}${window.location.pathname}`;
  showLanguageMenu.value = false;
};

const handleLogout = async () => {
  await api.logOut();
  window.location.href = '/users/sign_out';
};

// Close dropdowns when clicking outside
const handleClickOutside = (event) => {
  if (!event.target.closest('.relative')) {
    showLanguageMenu.value = false;
    showUserMenu.value = false;
  }
};

onMounted(() => {
  document.addEventListener('click', handleClickOutside);
});

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside);
});
</script>
