<template>
  <div class="space-y-6">
    <!-- Welcome Header -->
    <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700 p-6">
      <h1 class="text-2xl font-bold text-slate-900 dark:text-white mb-2">
        Welcome back, {{ currentUser?.firstName || 'Admin' }}!
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
            <FontAwesomeIcon
              :icon="['fas', 'briefcase']"
              class="w-5 h-5"
            />
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
            <FontAwesomeIcon
              :icon="['fas', 'people-group']"
              class="w-5 h-5"
            />
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
            <FontAwesomeIcon
              :icon="['fas', 'truck']"
              class="w-5 h-5"
            />
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
            <FontAwesomeIcon
              :icon="['fas', 'clock']"
              class="w-5 h-5"
            />
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
                  {{ user.firstName }} {{ user.lastName }}
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
          <FontAwesomeIcon
            :icon="['fas', 'fa-building']"
            class="w-5 h-5 text-slate-600 dark:text-slate-300 mr-3"
          />
          <span class="text-sm font-medium text-slate-700 dark:text-slate-300">Manage Companies</span>
        </router-link>

        <router-link
          :to="{ name: 'users' }"
          class="flex items-center p-4 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-slate-50
           dark:hover:bg-slate-700 transition-colors"
        >
          <FontAwesomeIcon
            :icon="['fas', 'fa-users']"
            class="w-5 h-5 text-slate-600 dark:text-slate-300 mr-3"
          />
          <span class="text-sm font-medium text-slate-700 dark:text-slate-300">Manage Users</span>
        </router-link>

        <router-link
          :to="{ name: 'products' }"
          class="flex items-center p-4 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-slate-50
           dark:hover:bg-slate-700 transition-colors"
        >
          <FontAwesomeIcon
            :icon="['fas', 'fa-box']"
            class="w-5 h-5 text-slate-600 dark:text-slate-300 mr-3"
          />
          <span class="text-sm font-medium text-slate-700 dark:text-slate-300">Manage Products</span>
        </router-link>

        <router-link
          :to="{ name: 'config' }"
          class="flex items-center p-4 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-slate-50
           dark:hover:bg-slate-700 transition-colors"
        >
          <FontAwesomeIcon
            :icon="['fas', 'fa-gear']"
            class="w-5 h-5 text-slate-600 dark:text-slate-300 mr-3"
          />
          <span class="text-sm font-medium text-slate-700 dark:text-slate-300">Settings</span>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useUserStore } from '@/admin/stores/user';
import api from '@/admin/api';

const { currentUser } = useUserStore();

const stats = ref({
  companies: 0,
  users: 0,
  products: 0,
  pendingProducts: 0
});

const recentUsers = ref([]);
const recentProducts = ref([]);

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
  return `${user.firstName?.[0] || ''}${user.lastName?.[0] || ''}`.toUpperCase();
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
