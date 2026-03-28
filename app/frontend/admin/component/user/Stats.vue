<template>
  <BaseCard
    :title="t('account_statistics')"
    header-level="3"
  >
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div class="bg-gradient-to-br from-blue-50 to-blue-100 rounded-lg p-6 border border-blue-200">
        <div class="text-3xl font-bold text-blue-600 dark:text-blue-400">
          {{ userStats.totalProducts || 0 }}
        </div>
        <p class="mt-2 text-sm text-blue-700 dark:text-blue-300 font-medium">
          {{ t('products_managed') }}
        </p>
      </div>
      <div class="bg-gradient-to-br from-green-50 to-green-100 rounded-lg p-6 border border-green-200">
        <div class="text-3xl font-bold text-green-600 dark:text-green-400">
          {{ userStats.pendingProducts || 0 }}
        </div>
        <p class="mt-2 text-sm text-green-700 dark:text-green-300 font-medium">
          {{ t('pending_orders') }}
        </p>
      </div>
      <div class="bg-gradient-to-br from-purple-50 to-purple-100 rounded-lg p-6 border border-purple-200">
        <div class="text-3xl font-bold text-purple-600 dark:text-purple-400">
          {{ userStats.completedProducts || 0 }}
        </div>
        <p class="mt-2 text-sm text-purple-700 dark:text-purple-300 font-medium">
          {{ t('completed_orders') }}
        </p>
      </div>
    </div>
  </BaseCard>
</template>
<script setup>
import { useI18n } from 'vue-i18n';
import BaseCard from '@/baseElements/BaseCard/BaseCard.vue';

defineProps({
  userStats: {
    type: Object,
    required: true,
  },
});
const { t } = useI18n();
</script>
<i18n lang="yaml">
  en:
    account_statistics: Account Statistics
    products_managed: Products Managed
    pending_orders: Pending Orders
    completed_orders: Completed Orders
  fr:
    account_statistics: Statistiques du Compte
    products_managed: Produits Gérés
    pending_orders: Commandes en Attente
    completed_orders: Commandes Terminées
  mg:
    account_statistics: Statistikan'ny Kaonty
    products_managed: Zavatra narahina
    pending_orders: komandy andalana
    completed_orders: komandy vita
</i18n>
