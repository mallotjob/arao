<template>
  <div
    :class="[
      'fixed inset-y-0 left-0 z-50 w-64 transform transition-transform duration-300 ease-in-out lg:translate-x-0 '
        + 'lg:static lg:inset-0 min-h-screen bg-white dark:bg-slate-900',
      sidebarOpen ? 'translate-x-0' : '-translate-x-full'
    ]"
  >
    <!-- Logo -->
    <div class="flex items-center h-16 px-6">
      <div class="flex items-center">
        <div class="w-8 h-8 bg-blue-500 rounded-lg flex items-center justify-center">
          <svg
            class="w-5 h-5 text-white"
            fill="currentColor"
            viewBox="0 0 20 20"
          >
            <path
              d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4
            10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0
            011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0
            001-1v-6.586l.293.293a1 1 0
            001.414-1.414l-7-7z"
            />
          </svg>
        </div>

        <span class="ml-3 text-xl font-semibold text-slate-900 dark:text-white">
          Follow Admin
        </span>
      </div>
    </div>

    <!-- Navigation -->
    <nav class="mt-6 px-3">
      <div class="space-y-1">
        <router-link
          v-for="item in navigation"
          :key="item.name"
          :to="{ name: item.route }"
          class="group flex items-center px-3 py-2 text-sm font-medium rounded-md transition-colors"
          :class="[
            $route.name === item.route
              ? 'bg-slate-100 text-slate-900 dark:bg-slate-800 dark:text-white'
              : 'text-slate-600 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-300'
                + 'dark:hover:bg-slate-700 dark:hover:text-white'
          ]"
        >
          <FontAwesomeIcon
            :icon="['fas', item.icon]"
            class="mr-3 h-5 w-5"
          />
          {{ t(item.name) }}
        </router-link>
      </div>

      <!-- Management Section -->
      <div class="mt-8">
        <h3 class="px-3 text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-wider">
          {{ t('management') }}
        </h3>

        <div
          v-for="item in managementNav"
          :key="item.name"
          class="mt-3 space-y-1"
        >
          <router-link
            v-if="canAccess(item.permission)"
            :to="{ name: item.route }"
            class="group flex items-center px-3 py-2 text-sm font-medium rounded-md transition-colors"
            :class="[
              $route.name === item.route
                ? 'bg-slate-100 text-slate-900 dark:bg-slate-800 dark:text-white'
                : 'text-slate-600 hover:bg-slate-100 hover:text-slate-900 dark:text-slate-300'
                  + 'dark:hover:bg-slate-700 dark:hover:text-white'
            ]"
          >
            {{ t(item.name) }}
          </router-link>
        </div>
      </div>
    </nav>
  </div>
</template>
<script setup>
import { useI18n } from 'vue-i18n';

defineProps({
  sidebarOpen: {
    type: Boolean,
    default: false
  }
});

const { t } = useI18n();


const navigation = [
  { name: 'dashboard', route: 'home', icon: 'house' },
  { name: 'account', route: 'account', icon: 'user' },
];

const managementNav = [
  { name: 'companies', route: 'companies', permission: 'manage_companies' },
  { name: 'users', route: 'companies', permission: 'manage_users' },
  { name: 'products', route: 'companies', permission: 'manage_products' },
  { name: 'shipping', route: 'companies', permission: 'manage_shipping' },
  { name: 'reports', route: 'companies', permission: 'view_reports' },
  { name: 'settings', route: 'companies', permission: 'manage_settings' },
];

const canAccess = () => {
  // This would integrate with your CASL permissions
  // For now, return true (admin has all permissions)
  return true;
};
</script>

<i18n lang="yaml">
  en:
    management: Management
    dashboard: Dashboard
    account: Account
    companies: Companies
    users: Users
    products: Products
    shipping: Shipping
    reports: Reports
    settings: Settings
  fr:
    management: Gestion
    dashboard: Tableau de bord
    account: Compte
    companies: Entreprises
    users: Utilisateurs
    products: Produits
    shipping: Livraison
    reports: Rapports
    settings: Paramètres
  mg:
    management: Fikirana
    dashboard: Sehatra
    account: Kaonty
    companies: Fikandrana
    users: Mpampiasa
    products: Zavatra
    shipping: Fandefasana
    reports: Raporty
    settings: Fikirana
  zh-CN:
    management: 管理
    dashboard: 仪表板
    account: 账户
    companies: 公司
    users: 用户
    products: 产品
    shipping: 配送
    reports: 报表
    settings: 设置
</i18n>
