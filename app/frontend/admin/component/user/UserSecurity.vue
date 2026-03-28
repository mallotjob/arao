<template>
  <BaseCard
    :title="t('security_setting')"
    header-level="3"
  >
    <div class="space-y-4">
      <div class="flex items-center justify-between">
        <div>
          <p class="text-sm font-medium text-slate-700 dark:text-white">
            {{ t('change_password') }}
          </p>
          <p class="text-sm text-slate-500 dark:text-slate-300">
            {{ t('update_password') }}
          </p>
        </div>
        <BaseButton
          color-type="outline"
          @click="showPasswordModal = true"
        >
          {{ t('change_password') }}
        </BaseButton>
      </div>
    </div>
  </BaseCard>

  <!-- Password Change Modal -->
  <BaseModal
    v-if="showPasswordModal"
    @on-close="showPasswordModal = false"
  >
    <BaseTitle
      level="h3"
      class="mb-4"
    >
      {{ t('change_password') }}
    </BaseTitle>
    <form @submit.prevent="changePassword">
      <div class="space-y-4">
        <div>
          <label class="block text-sm font-medium text-slate-700 dark:text-white mb-1">{{ t('current_password') }}</label>
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
          <label class="block text-sm font-medium text-slate-700 dark:text-white mb-1">{{ t('new_password') }}</label>
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
          <label class="block text-sm font-medium text-slate-700 dark:text-white mb-1">
            {{ t('confirm_new_password') }}
          </label>
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
        <BaseButton
          type="button"
          color="light"
          @click="showPasswordModal = false"
        >
          {{ t('cancel') }}
        </BaseButton>
        <BaseButton
          type="submit"
          color="primary"
          :disabled="isChangingPassword"
        >
          {{ isChangingPassword ? t('changing') : t('change_password') }}
        </BaseButton>
      </div>
    </form>
  </BaseModal>
</template>
<script setup>
import { ref } from 'vue';
import { useI18n } from 'vue-i18n';
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';
import BaseCard from '@/baseElements/BaseCard/BaseCard.vue';
import BaseModal from '@/baseElements/BaseModal/BaseModal.vue';
import BaseTitle from '@/baseElements/BaseTitle/BaseTitle.vue';

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
    change_password: Change Password
    current_password: Current Password
    new_password: New Password
    confirm_new_password: Confirm New Password
    cancel: Cancel
    changing: Changing...
    update_password: Update Password
  fr:
    security_setting: Paramètres de sécurité
    change_password: Changer le mot de passe
    current_password: Mot de passe actuel
    new_password: Nouveau mot de passe
    confirm_new_password: Confirmer le nouveau mot de passe
    cancel: Annuler
    changing: Changement en cours...
    update_password: Mettre à jour le mot de passe
  mg:
    security_setting: Fikirana ny fiarovana
    change_password: Ovay ny teny miafina
    current_password: Teny miafina ankehitriny
    new_password: Teny miafina vaovao
    confirm_new_password: Anamafy ny teny miafina vaovao
    cancel: Fanafoana
    changing: Ovay...
    update_password: Ovay ny teny miafina
  zh-CN:
    security_setting: 安全设置
    change_password: 更改密码
    current_password: 当前密码
    new_password: 新密码
    confirm_new_password: 确认新密码
    cancel: 取消
    changing: 更改中...
    update_password: 更新密码
</i18n>
