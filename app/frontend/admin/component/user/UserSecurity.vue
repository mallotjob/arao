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
    <Form
      :validation-schema="validationSchema"
      @submit="handleUpdatePassword"
    >
      <div class="space-y-4">
        <Field
          v-slot="{ field, errorMessage }"
          name="current_password"
        >
          <BaseInput
            :model-value="field.value"
            type="password"
            :label="t('current_password')"
            :placeholder="t('current_password')"
            :error="errorMessage"
            autocomplete="current-password"
            @update:model-value="field.onChange($event)"
          />
        </Field>
        <Field
          v-slot="{ field, errorMessage }"
          name="password"
        >
          <BaseInput
            :model-value="field.value"
            type="password"
            :label="t('new_password')"
            :placeholder="t('new_password')"
            :error="errorMessage"
            autocomplete="new-password"
            :help-text="t('password_min_length')"
            @update:model-value="field.onChange($event)"
          />
        </Field>
        <Field
          v-slot="{ field, errorMessage }"
          name="password_confirmation"
        >
          <BaseInput
            :model-value="field.value"
            type="password"
            :label="t('confirm_new_password')"
            :placeholder="t('confirm_new_password')"
            :error="errorMessage"
            autocomplete="new-password"
            @update:model-value="field.onChange($event)"
          />
        </Field>
      </div>
      <div class="mt-6 flex justify-end space-x-3">
        <BaseButton
          type="button"
          color="light"
          :label="t('cancel')"
          @click="showPasswordModal = false"
        />
        <BaseButton
          type="submit"
          :label="t('change_password')"
          :loading="isChangingPassword"
          :disabled="isChangingPassword"
        />
      </div>
    </Form>
  </BaseModal>
</template>
<script setup>
import { computed, ref } from 'vue';
import { Field, Form } from 'vee-validate';
import { showErrorToast, showSuccessToast } from '@/shared/composables/useNotificationSystem';
import { useI18n } from 'vue-i18n';
import { useLoaderStatus } from '@/shared/composables/loaderStatus';
import { usePasswordValidationSchema } from '@/composables/useValidationSchemas';
import api from '@/admin/api';
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';
import BaseCard from '@/baseElements/BaseCard/BaseCard.vue';
import BaseInput from '@/baseElements/BaseInput/BaseInput.vue';
import BaseModal from '@/baseElements/BaseModal/BaseModal.vue';
import BaseTitle from '@/baseElements/BaseTitle/BaseTitle.vue';
import waitKeys from '@/shared/utils/wait-keys';

const { userId } = defineProps({
  userId: {
    type: String,
    required: true
  }
});

const { is, start, end } = useLoaderStatus();
const { t } = useI18n();
const validationSchema = usePasswordValidationSchema(t);

const showPasswordModal = ref(false);

const isChangingPassword = computed(() => {
  return is.value[waitKeys.UPDATE_USERS_PASSWORD_WAIT_KEY];
});

const handleUpdatePassword = async (values) => {
  try {
    start(waitKeys.UPDATE_USERS_PASSWORD_WAIT_KEY);
    await api.updatePassword(userId, { user: values });
    showSuccessToast(t('password_updated_successfully'));
    showPasswordModal.value = false;
  } catch (e) {
    if (e.error === 'incorrect_current_password') {
      showErrorToast(t('incorrect_current_password'));
    } else {
      showErrorToast(t('password_update_failed'));
    }
  } finally {
    end(waitKeys.UPDATE_USERS_PASSWORD_WAIT_KEY);
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
    update_password: 更新密码
    password_updated_successfully: 密码更新成功！
    password_update_failed: 密码更新失败
    password_min_length: 密码必须至少8个字符
    incorrect_current_password: 当前密码不正确
</i18n>
