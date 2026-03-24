<template>
  <BaseCard
    :title="t('profile_info')"
    header-level="3"
  >
    <div class="p-6 flex items-start space-x-6">
      <!-- Avatar -->
      <div class="flex-shrink-0">
        <div
          class="w-24 h-24 bg-gradient-to-br from-blue-500 to-purple-600 rounded-full
              flex items-center justify-center
              shadow-lg dark:shadow-slate-900/50
              ring-4 ring-white dark:ring-slate-800"
        >
          <span class="text-3xl font-bold dark:text-white text-slate-900">
            {{ userInitials(currentUser) }}
          </span>
        </div>
      </div>
      <!-- Basic Info -->
      <div class="flex-1 grid grid-cols-1 md:grid-cols-2 gap-6">
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
                d="M16 7a4 4 0 11-8 0v4a4 4 0 018 0v-4z"
              />
            </svg>
            <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
              {{ $t('first_name') }}
            </label>
          </div>
          <p class="text-base font-medium text-slate-900 dark:text-white">
            {{ currentUser.firstName || 'N/A' }}
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
                d="M16 7a4 4 0 11-8 0v4a4 4 0 018 0v-4z"
              />
            </svg>
            <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
              {{ $t('last_name') }}
            </label>
          </div>
          <p class="text-base font-medium text-slate-900 dark:text-white">
            {{ currentUser.lastName || 'N/A' }}
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
                d="M3 8l7.89 5.26a2 2 0 002.22 2.2H21V8z"
              />
            </svg>
            <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
              {{ $t('email') }}
            </label>
          </div>
          <p class="text-base font-medium text-slate-900 dark:text-white">
            {{ currentUser.email || 'N/A' }}
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
                d="M16 7a4 4 0 11-8 0v4a4 4 0 018 0v-4z"
              />
            </svg>
            <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
              {{ $t('username') }}
            </label>
          </div>
          <p class="text-base font-medium text-slate-900 dark:text-white">
            {{ currentUser.username || 'N/A' }}
          </p>
        </BaseCard>
      </div>
    </div>
  </BaseCard>
</template>
<script setup>
import { useI18n } from 'vue-i18n';
import BaseCard from '@/baseElements/BaseCard/BaseCard.vue';

defineProps({
  currentUser: {
    type: Object,
    required: true
  }
});

const { t } = useI18n();

const userInitials = (user) => {
  return `${user.firstName?.[0] || ''}${user.lastName?.[0] || ''}`.toUpperCase();
};
</script>
<i18n lang="yaml">
  en:
    profile_info: Profile Information
  fr:
    profile_info: Informations du profil
  mg:
    profile_info: Mombamomba ny kaonty
  zh-CN:
    profile_info: 个人信息
</i18n>
