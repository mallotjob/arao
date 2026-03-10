<template>
  <div class="min-h-screen bg-slate-50 flex">
    <!-- Sidebar -->
    <div
      :class="[
        'fixed inset-y-0 left-0 z-50 w-64 bg-slate-900 transform transition-transform duration-300 ease-in-out '
          + 'lg:translate-x-0 lg:static lg:inset-0 min-h-screen',
        sidebarOpen ? 'translate-x-0' : '-translate-x-full'
      ]"
    >
      <!-- Logo -->
      <div class="flex items-center h-16 px-6 border-b border-slate-700">
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
    <div class="w-full">
      <Header @toggle-sidebar="toggleSidebar" />
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
import { ref } from 'vue';
import Header from '@/admin/layouts/Header.vue';
// import { useRouter } from 'vue-router'

// const router = useRouter()
const sidebarOpen = ref(false);

// User data (this would come from your auth state)

// Navigation items
// const navigation = [
//   { name: 'Dashboard', route: 'home', icon: HomeIcon },
//   { name: 'Account', route: 'account', icon: UserIcon },
// ];

const managementNav = [
  { name: 'Companies', route: 'companies', permission: 'manage_companies' },
  { name: 'Users', route: 'users', permission: 'manage_users' },
  { name: 'Products', route: 'products', permission: 'manage_products' },
  { name: 'Shipping', route: 'shipping', permission: 'manage_shipping' },
  { name: 'Reports', route: 'reports', permission: 'view_reports' },
  { name: 'Settings', route: 'settings', permission: 'manage_settings' },
];

// Methods
const toggleSidebar = () => {
  sidebarOpen.value = !sidebarOpen.value;
};

// const canAccess = (permission) => {
//   // This would integrate with your CASL permissions
//   // For now, return true (admin has all permissions)
//   return true;
// };
</script>
