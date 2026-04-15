<template>
  <div class="space-y-6">
    <!-- Welcome Header -->
    <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700 p-6">
      <h1 class="text-2xl font-bold text-slate-900 dark:text-white mb-2">
        {{ t('title.welcome') }}, {{ currentUser?.firstName || 'Admin' }}!
      </h1>
      <p class="text-slate-600 dark:text-slate-300">
        {{ t('dashboard.welcome_message') }}
      </p>
    </div>

    <!-- Stats Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
      <Can
        do="manage"
        on="Company"
      >
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
                {{ t('total.companies') }}
              </p>
              <p class="text-2xl font-semibold text-slate-900 dark:text-white">
                {{ stats.companies }}
              </p>
            </div>
          </div>
        </div>
      </Can>
      <Can
        do="read"
        on="User"
      >
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
                {{ t('total.users') }}
              </p>
              <p class="text-2xl font-semibold text-slate-900 dark:text-white">
                {{ stats.users }}
              </p>
            </div>
          </div>
        </div>
      </Can>

      <Can
        do="read"
        on="Product"
      >
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
                {{ t('total.products') }}
              </p>
              <p class="text-2xl font-semibold text-slate-900 dark:text-white">
                {{ stats.products }}
              </p>
            </div>
          </div>
        </div>
      </Can>
      <Can
        do="read"
        on="Order"
      >
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
                {{ t('total.pendingOrders') }}
              </p>
              <p class="text-2xl font-semibold text-slate-900 dark:text-white">
                {{ stats.pendingProducts }}
              </p>
            </div>
          </div>
        </div>
      </Can>
    </div>

    <!-- Recent Activity -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- Recent Users -->
      <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700">
        <div class="px-6 py-4 border-b border-slate-200 dark:border-slate-700">
          <h3 class="text-lg font-medium text-slate-900 dark:text-white">
            {{ t('title.user') }}
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
                  {{ user.fullName || `${user.firstName} ${user.lastName}` }}
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
            {{ t('title.product') }}
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
        {{ t('title.action') }}
      </h3>
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <Can
          do="manage"
          on="Company"
        >
          <router-link
            :to="{ name: 'companies' }"
            class="flex items-center p-4 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-slate-50
           dark:hover:bg-slate-700 transition-colors"
          >
            <FontAwesomeIcon
              :icon="['fas', 'fa-building']"
              class="w-5 h-5 text-slate-600 dark:text-slate-300 mr-3"
            />
            <span class="text-sm font-medium text-slate-700 dark:text-slate-300">
              {{ t('manage.companies') }}
            </span>
          </router-link>
        </Can>
        <Can
          do="read"
          on="User"
        >
          <router-link
            :to="{ name: 'users' }"
            class="flex items-center p-4 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-slate-50
           dark:hover:bg-slate-700 transition-colors"
          >
            <FontAwesomeIcon
              :icon="['fas', 'fa-users']"
              class="w-5 h-5 text-slate-600 dark:text-slate-300 mr-3"
            />
            <span class="text-sm font-medium text-slate-700 dark:text-slate-300">
              {{ t('manage.users') }}
            </span>
          </router-link>
        </Can>
        <Can
          do="read"
          on="Product"
        >
          <router-link
            :to="{ name: 'products' }"
            class="flex items-center p-4 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-slate-50
           dark:hover:bg-slate-700 transition-colors"
          >
            <FontAwesomeIcon
              :icon="['fas', 'fa-box']"
              class="w-5 h-5 text-slate-600 dark:text-slate-300 mr-3"
            />
            <span class="text-sm font-medium text-slate-700 dark:text-slate-300">
              {{ t('manage.products') }}
            </span>
          </router-link>
        </Can>
        <Can
          do="read"
          on="Config"
        >
          <router-link
            :to="{ name: 'config' }"
            class="flex items-center p-4 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-slate-50
           dark:hover:bg-slate-700 transition-colors"
          >
            <FontAwesomeIcon
              :icon="['fas', 'fa-gear']"
              class="w-5 h-5 text-slate-600 dark:text-slate-300 mr-3"
            />
            <span class="text-sm font-medium text-slate-700 dark:text-slate-300">
              {{ t('manage.settings') }}
            </span>
          </router-link>
        </Can>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useI18n } from 'vue-i18n';
import { useUserStore } from '@/admin/stores/user';
import api from '@/admin/api';

const { t } = useI18n();
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
      api.companies.getAll(),
      api.users.getAll(),
      api.products.getAll()
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
  const fullName = user.full_name || `${user.firstName || ''} ${user.lastName || ''}`.trim();
  return fullName.split(' ').map(name => name[0]).join('').toUpperCase();
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
<i18n lang="yaml">
  en:
    title:
      welcome: Welcome back
      user: Recent Users
      product: Recent Products
      action: Quick Actions
    dashboard:
      welcome_message: Here's what's happening with your application today.
    total:
      companies: Total Companies
      users: Total Users
      products: Total Products
      pendingOrders: Pending Orders
    manage:
      companies: Manage Companies
      users: Manage Users
      products: Manage Products
      settings: Settings

  fr:
    title:
      welcome: Bon retour
      user: Utilisateurs récents
      product: Produits récents
      action: Actions rapides
    dashboard:
      welcome_message: Voici ce qui se passe avec votre application aujourd'hui.
    total:
      companies: Totale d'entreprises
      users: Total d'utilisateurs
      products: Total de produits
      pendingOrders: Commandes en attente
    manage:
      companies: Gérer les entreprises
      users: Gérer les utilisateurs
      products: Gérer les produits
      settings: Paramètres
  mg:
    title:
      welcome: Tongasoa indray
      user: Mpampiasa varaika
      product: Zavatra vaovao
      action: Etsika aingana
    dashboard:
      welcome_message: Indro ny zavatra mitranga ankehitriny amin'ny application.
    total:
      companies: Totaly orinasa
      users: Totaly mpampiasa
      products: Totaly zavatra
      pendingOrders: Komandy mandeha
    manage:
      companies: Fikirana orinasa
      users: Fikirana mpampiasa
      products: Fikirana zavatra
      settings: Fikirakirana
  zh-CN:
    title:
      welcome: 欢迎回来
      user: 最近用户
      product: 最近产品
      action: 快捷操作
    dashboard:
      welcome_message: 这里是您应用今天的情况。
    total:
      companies: 总公司数
      users: 总用户数
      products: 总产品数
      pendingOrders: 在途订单
    manage:
      companies: 管理公司
      users: 管理用户
      products: 管理产品
      settings: 设置
</i18n>
