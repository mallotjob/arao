<template>
  <BaseCard
    :title="t('security_setting')"
    header-level="3"
  >
    <div class="space-y-4">
      <div class="flex items-center justify-between">
        <div>
          <p class="text-sm font-medium text-slate-700 dark:text-white">
            Change Password
          </p>
          <p class="text-sm text-slate-500 dark:text-slate-300">
            Update your password to keep your account secure
          </p>
        </div>
        <BaseButton
          color-type="outline"
          @click="showPasswordModal = true"
        >
          Change Password
        </BaseButton>
      </div>
    </div>
  </BaseCard>

  <!-- Password Change Modal -->
  <div
    v-if="showPasswordModal"
    class="fixed -top-6 inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
  >
    <div class="bg-white dark:bg-slate-800 rounded-lg p-6 w-full max-w-md">
      <h3 class="text-xl font-semibold mb-4 text-slate-900 dark:text-white">
        Change Password
      </h3>
      <form @submit.prevent="changePassword">
        <div class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-slate-700 dark:text-white mb-1">Current Password</label>
            <input
              v-model="passwordForm.current_password"
              type="password"
              required
              class="w-full px-3 py-2 border border-slate-300 dark:border-slate-600 rounded-lg
                bg-white dark:bg-slate-700
                text-slate-900 dark:text-white
                focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            >
          </div>
          <div>
            <label class="block text-sm font-medium text-slate-700 dark:text-white mb-1">New Password</label>
            <input
              v-model="passwordForm.password"
              type="password"
              required
              minlength="8"
              class="w-full px-3 py-2 border border-slate-300 dark:border-slate-600 rounded-lg
                bg-white dark:bg-slate-700
                text-slate-900 dark:text-white
                focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            >
          </div>
          <div>
            <label class="block text-sm font-medium text-slate-700 dark:text-white mb-1">Confirm New Password</label>
            <input
              v-model="passwordForm.password_confirmation"
              type="password"
              required
              minlength="8"
              class="w-full px-3 py-2 border border-slate-300 dark:border-slate-600 rounded-lg
                bg-white dark:bg-slate-700
                text-slate-900 dark:text-white
                focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            >
          </div>
        </div>
        <div class="mt-6 flex justify-end space-x-3">
          <button
            type="button"
            class="px-4 py-2 text-slate-700 dark:text-white border border-slate-300 rounded-lg
              hover:bg-slate-50 dark:hover:bg-slate-500 transition-colors"
            @click="showPasswordModal = false"
          >
            Cancel
          </button>
          <button
            type="submit"
            class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
            :disabled="isChangingPassword"
          >
            {{ isChangingPassword ? 'Changing...' : 'Change Password' }}
          </button>
        </div>
      </form>
    </div>
  </div>
</template>
<script setup>
import { ref } from 'vue';
import { useI18n } from 'vue-i18n';
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';
import BaseCard from '@/baseElements/BaseCard/BaseCard.vue';

const { t } = useI18n();
const showPasswordModal = ref(false);
const passwordForm = ref({
  current_password: '',
  password: '',
  password_confirmation: ''
});
const isChangingPassword = ref(false);
</script>
<i18n lang="yaml">
  en:
    security_setting: Security Settings
  fr:
    security_setting:



</i18n>
