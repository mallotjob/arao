<template>
  <div class="bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700 p-6">
    <h1 class="text-2xl font-semibold text-slate-900 dark:text-white">
      {{ t('account_details') }}
    </h1>
    <p class="mt-1 text-sm text-slate-600 dark:text-slate-300">
      {{ t('view_profile') }}
    </p>
  </div>
</template>
<script setup>
import { useI18n } from 'vue-i18n';

const { t } = useI18n();
</script>
<i18n lang="yaml">
  en:
    account_details: Account Details
    view_profile: View profile and account information
  fr:
    account_details: Détails du compte
    view_profile: Voir le profil et les informations du compte
  mg:
    account_details: Mombamomba ny kaonty
    view_profile: Jereo ny kaonty sy ny mombamomba azy
  zh-CN:
    account_details: 账户详情
    view_profile: 查看个人资料和账户信息
</i18n>
