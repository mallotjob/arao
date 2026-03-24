<template>
  <BaseCard
    :title="t('company_information')"
    header-level="3"
  >
    <div class="p-6 space-y-4">
      <BaseCard :card-inside="true">
        <div class="flex items-center mb-2">
          <svg
            class="w-4 h-4 text-slate-400 mr-2"
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
          <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
            {{ t('company') }}
          </label>
        </div>
        <p class="text-base font-medium text-slate-900 dark:text-white">
          {{ currentUser.company?.name || t('no_company_assigned') }}
        </p>
      </BaseCard>
      <BaseCard :card-inside="true">
        <div class="flex items-center mb-2">
          <svg
            class="w-4 h-4 text-slate-400 mr-2"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 114 0V1m-4 0a2 2
                  0 104 0m-5 8a2 2 0 100-4 2 2 0 000 4zm0 0C1.306 0 2.417.835 2.83 2M9 14a3.001 3.001 0 00-2.83 2M15
                  11h3m-3 4h2"
            />
          </svg>
          <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
            {{ t('company_id') }}
          </label>
        </div>
        <p class="text-base font-medium text-slate-900 dark:text-white">
          {{ currentUser.company_id || 'N/A' }}
        </p>
      </BaseCard>
    </div>
  </BaseCard>
</template>
<script setup>
import { useI18n } from 'vue-i18n';
import BaseCard from '@/baseElements/BaseCard/BaseCard.vue';

defineProps({
  currentUser: {
    type: Object,
    required: true,
  },
});
const { t } = useI18n();
</script>
<i18n lang="yaml">
  en:
    company_information: Company Information
    company: Company
    no_company_assigned: No company assigned
    company_id: Company ID
  fr:
    company_information: Informations sur l'entreprise
    company: Entreprise
    no_company_assigned: Aucune entreprise assignée
    company_id: ID de l'entreprise
  mg:
    company_information: Mombamomba ny fiasana
    company: Fiasana
    no_company_assigned: Tsy misy fiasana voatanisa
    company_id: ID ny fiasana
  zh-CN:
    company_information: 公司信息
    company: 公司
    no_company_assigned: 未分配公司
    company_id: 公司ID
</i18n>
