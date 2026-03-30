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
    <form @submit.prevent="handleUpdatePassword">
      <div class="space-y-4">
        <BaseInput
          v-model="passwordForm.current_password"
          type="password"
          :label="t('current_password')"
          :placeholder="t('current_password')"
          required
          autocomplete="current-password"
        />
        <BaseInput
          v-model="passwordForm.password"
          type="password"
          :label="t('new_password')"
          :placeholder="t('new_password')"
          :minlength="8"
          autocomplete="new-password"
          required
          :help-text="t('password_min_length')"
        />
        <BaseInput
          v-model="passwordForm.password_confirmation"
          type="password"
          :label="t('confirm_new_password')"
          :placeholder="t('confirm_new_password')"
          :minlength="8"
          required
          autocomplete="new-password"
        />
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
import { showErrorToast, showSuccessToast } from '@/composables/useNotificationSystem';
import { useI18n } from 'vue-i18n';
import api from '@/admin/api';
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';
import BaseCard from '@/baseElements/BaseCard/BaseCard.vue';
import BaseInput from '@/baseElements/BaseInput/BaseInput.vue';
import BaseModal from '@/baseElements/BaseModal/BaseModal.vue';
import BaseTitle from '@/baseElements/BaseTitle/BaseTitle.vue';

const { userId } = defineProps({
  userId: {
    type: String,
    required: true
  }
});

const { t } = useI18n();
const showPasswordModal = ref(false);
const passwordForm = ref({
  current_password: '',
  password: '',
  password_confirmation: ''
});
const isChangingPassword = ref(false);


const handleUpdatePassword = async () => {
  try {
    isChangingPassword.value = true;
    await api.updatePassword(userId, { user: passwordForm.value });
    showSuccessToast(t('password_updated_successfully'));
    showPasswordModal.value = false;
    passwordForm.value = {
      current_password: '',
      password: '',
      password_confirmation: ''
    };
  } catch (e) {
    console.error(e.error);
    if (e.error === 'incorrect_current_password') {
      showErrorToast(t('incorrect_current_password'));
    } else {
      showErrorToast(t('password_update_failed'));
    }
  } finally {
    isChangingPassword.value = false;
  }
};

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
    password_updated_successfully: Password updated successfully!
    password_update_failed: Failed to update password
    password_min_length: Password must be at least 8 characters
    incorrect_current_password: Current password is incorrect
  fr:
    security_setting: Paramètres de sécurité
    change_password: Changer le mot de passe
    current_password: Mot de passe actuel
    new_password: Nouveau mot de passe
    confirm_new_password: Confirmer le nouveau mot de passe
    cancel: Annuler
    changing: Changement en cours...
    update_password: Mettre à jour le mot de passe
    password_updated_successfully: Mot de passe mis à jour avec succès!
    password_update_failed: Échec de la mise à jour du mot de passe
    password_min_length: Le mot de passe doit contenir au moins 8 caractères
    incorrect_current_password: Le mot de passe actuel est incorrect
  mg:
    security_setting: Fikirana ny fiarovana
    change_password: Ovay ny teny miafina
    current_password: Teny miafina ankehitriny
    new_password: Teny miafina vaovao
    confirm_new_password: Hamarino ny teny miafina vaovao
    cancel: Fanafoana
    changing: Ovay...
    update_password: Ovay ny teny miafina
    password_updated_successfully: Tena miafina novaina!
    password_update_failed: Tsy hadisoana ny fiovana
    password_min_length: Ny teny miafina dia tsy maintsy 8 farany kely
    incorrect_current_password: Diso ny tena miafina ankehitriny
  zh-CN:
    security_setting: 安全设置
    change_password: 更改密码
    current_password: 当前密码
    new_password: 新密码
    confirm_new_password: 确认新密码
    cancel: 取消
    changing: 更改中...
    update_password: 更新密码
    password_updated_successfully: 密码更新成功！
    password_update_failed: 密码更新失败
    password_min_length: 密码必须至少8个字符
    incorrect_current_password: 当前密码不正确
</i18n>
