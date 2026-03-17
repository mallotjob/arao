<template>
  <div class="space-y-6">
    <!-- Welcome Header -->
    <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700 p-6">
      <h1 class="text-2xl font-bold text-slate-900 dark:text-white mb-2">
        Welcome back, {{ currentUser?.first_name || 'Admin' }}!
      </h1>
      <p class="text-slate-600 dark:text-slate-300">
        Here's what's happening with your application today.
      </p>
    </div>

    <!-- Stats Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
      <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700 p-6">
        <div class="flex items-center">
          <div class="p-3 bg-blue-500 rounded-lg">
            <svg
              class="w-6 h-6 text-white"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2a3 3 0 00-5.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7
                 20v-2c0-1.657 2.421-3 5.356-3m0 6h10a3 3 0 003-3v-2c0-1.657-2.421-3-5.356-3m-10 6a3 3 0 01-3 3v2a3 3 0
                 003 3m0-6V5a3 3 0 013-3h2a3 3 0 013 3v2"
              />
            </svg>
          </div>
          <div class="ml-4">
            <p class="text-sm font-medium text-slate-600 dark:text-slate-300">
              Total Companies
            </p>
            <p class="text-2xl font-semibold text-slate-900 dark:text-white">
              {{ stats.companies }}
            </p>
          </div>
        </div>
      </div>

      <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700 p-6">
        <div class="flex items-center">
          <div class="p-3 bg-green-500 rounded-lg">
            <svg
              class="w-6 h-6 text-white"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5
                0 2.5 2.5 0 015 0z"
              />
            </svg>
          </div>
          <div class="ml-4">
            <p class="text-sm font-medium text-slate-600 dark:text-slate-300">
              Total Users
            </p>
            <p class="text-2xl font-semibold text-slate-900 dark:text-white">
              {{ stats.users }}
            </p>
          </div>
        </div>
      </div>

      <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700 p-6">
        <div class="flex items-center">
          <div class="p-3 bg-purple-500 rounded-lg">
            <svg
              class="w-6 h-6 text-white"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M20 7l-8-4-8 4m16 0l-8 4m8-5v4l-8 2m0-4l-8-2m8 4v10m-4-4h4"
              />
            </svg>
          </div>
          <div class="ml-4">
            <p class="text-sm font-medium text-slate-600 dark:text-slate-300">
              Total Products
            </p>
            <p class="text-2xl font-semibold text-slate-900 dark:text-white">
              {{ stats.products }}
            </p>
          </div>
        </div>
      </div>

      <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700 p-6">
        <div class="flex items-center">
          <div class="p-3 bg-yellow-500 rounded-lg">
            <svg
              class="w-6 h-6 text-white"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
              />
            </svg>
          </div>
          <div class="ml-4">
            <p class="text-sm font-medium text-slate-600 dark:text-slate-300">
              Pending Orders
            </p>
            <p class="text-2xl font-semibold text-slate-900 dark:text-white">
              {{ stats.pendingProducts }}
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- Recent Activity -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- Recent Users -->
      <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700">
        <div class="px-6 py-4 border-b border-slate-200 dark:border-slate-700">
          <h3 class="text-lg font-medium text-slate-900 dark:text-white">
            Recent Users
          </h3>
        </div>
        <div class="p-6">
          <div class="space-y-4">
            <div
              v-for="user in recentUsers"
              :key="user.id"
              class="flex items-center"
            >
              <div class="w-8 h-8 bg-blue-500 rounded-full flex items-center justify-center">
                <span class="text-sm font-medium text-white">{{ userInitials(user) }}</span>
              </div>
              <div class="ml-3">
                <p class="text-sm font-medium text-slate-900 dark:text-white">
                  {{ user.first_name }} {{ user.last_name }}
                </p>
                <p class="text-sm text-slate-500 dark:text-slate-300">
                  {{ user.email }}
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Recent Products -->
      <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700">
        <div class="px-6 py-4 border-b border-slate-200 dark:border-slate-700">
          <h3 class="text-lg font-medium text-slate-900 dark:text-white">
            Recent Products
          </h3>
        </div>
        <div class="p-6">
          <div class="space-y-4">
            <div
              v-for="product in recentProducts"
              :key="product.id"
              class="flex items-center justify-between"
            >
              <div>
                <p class="text-sm font-medium text-slate-900 dark:text-white">
                  {{ product.commodity }}
                </p>
                <p class="text-sm text-slate-500 dark:text-slate-300">
                  {{ formatDate(product.created_at) }}
                </p>
              </div>
              <span
                class="px-2 py-1 text-xs rounded-full"
                :class="getStatusClass(product.aasm_state)"
              >
                {{ product.aasm_state?.capitalize() }}
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Quick Actions -->
    <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700 p-6">
      <h3 class="text-lg font-medium text-slate-900 dark:text-white mb-4">
        Quick Actions
      </h3>
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <router-link
          :to="{ name: 'companies' }"
          class="flex items-center p-4 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-slate-50
           dark:hover:bg-slate-700 transition-colors"
        >
          <svg
            class="w-6 h-6 text-slate-600 dark:text-slate-300 mr-3"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5
              10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"
            />
          </svg>
          <span class="text-sm font-medium text-slate-700 dark:text-slate-300">Manage Companies</span>
        </router-link>

        <!-- <router-link
          :to="{ name: 'users' }"
          class="flex items-center p-4 border border-slate-200 rounded-lg hover:bg-slate-50 transition-colors"
        >
          <svg
            class="w-6 h-6 text-slate-600 mr-3"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0
              2.5 2.5 0 015 0z"
            />
          </svg>
          <span class="text-sm font-medium text-slate-700">Manage Users</span>
        </router-link> -->

        <router-link
          :to="{ name: 'products' }"
          class="flex items-center p-4 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-slate-50
           dark:hover:bg-slate-700 transition-colors"
        >
          <svg
            class="w-6 h-6 text-slate-600 dark:text-slate-300 mr-3"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M20 7l-8-4-8 4m16 0l-8 4m8-5v4l-8 2m0-4l-8-2m8 4v10m-4-4h4"
            />
          </svg>
          <span class="text-sm font-medium text-slate-700 dark:text-slate-300">Manage Products</span>
        </router-link>

        <!-- <router-link
          :to="{ name: 'settings' }"
          class="flex items-center p-4 border border-slate-200 rounded-lg hover:bg-slate-50 transition-colors"
        >
          <svg
            class="w-6 h-6 text-slate-600 mr-3"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37
              2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c-.94
              1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426-1.756-2.924-1.756-3.35 0a1.724 1.724
              0 00-2.573 1.066c-.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-1.065 2.572C8.66 8.749 8.66 7.192 9.085
              5.842c-.426-1.756-2.924-1.756-3.35 0a1.724 1.724 0 00-2.573 1.066c-.94 1.543-.826 3.31-2.37 2.37a1.724
              1.724 0 00-1.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 002.573-1.066c1.543-.94 3.31-.826
              2.37-2.37a1.724 1.724 0 001.065-2.572c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573-1.066c1.543.94
              3.31.826 2.37 2.37.001.724 0 001.065-2.572z"
            />
          </svg>
          <span class="text-sm font-medium text-slate-700">Settings</span>
        </router-link> -->
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import api from '@/admin/api';

const stats = ref({
  companies: 0,
  users: 0,
  products: 0,
  pendingProducts: 0
});

const recentUsers = ref([]);
const recentProducts = ref([]);

const currentUser = ref({
  first_name: 'Admin',
  last_name: 'User'
});

const loadDashboardData = async () => {
  try {
    // Load stats
    const [companiesRes, usersRes, productsRes] = await Promise.all([
      api.getCompanies(),
      api.getUsers(),
      api.getProducts()
    ]);

    stats.value = {
      companies: companiesRes.data.length,
      users: usersRes.data.length,
      products: productsRes.data.length,
      pendingProducts: productsRes.data.filter(p => p.aasm_state === 'pending').length
    };

    // Load recent data (last 5)
    recentUsers.value = usersRes.data.slice(0, 5);
    recentProducts.value = productsRes.data.slice(0, 5);
  } catch (error) {
    console.error('Error loading dashboard data:', error);
  }
};

const userInitials = (user) => {
  return `${user.first_name?.[0] || ''}${user.last_name?.[0] || ''}`.toUpperCase();
};

const getStatusClass = (status) => {
  const statusClasses = {
    pending: 'bg-yellow-100 text-yellow-800',
    confirmed: 'bg-blue-100 text-blue-800',
    shipped: 'bg-purple-100 text-purple-800',
    completed: 'bg-green-100 text-green-800',
    delivered: 'bg-emerald-100 text-emerald-800'
  };
  return statusClasses[status] || 'bg-gray-100 text-gray-800';
};

const formatDate = (date) => {
  return new Date(date).toLocaleDateString();
};

onMounted(() => {
  loadDashboardData();
});
</script>
