<template>
  <BaseModal
    v-if="visible"
    :large="true"
    @on-close="handleClose"
  >
    <template #title>
      {{ isEditing ? t('edit_user') : t('create_user') }}
    </template>

    <Form
      :validation-schema="validationSchema"
      :initial-values="formData"
      @submit="handleSubmit"
    >
      <div class="space-y-4">
        <!-- Basic Information -->
        <Field
          v-slot="{ field, errorMessage }"
          name="firstName"
        >
          <BaseInput
            :label="$t('first_name')"
            type="text"
            :model-value="field.value"
            :error="errorMessage"
            required
            @update:model-value="field.onChange"
          />
        </Field>

        <Field
          v-slot="{ field, errorMessage }"
          name="lastName"
        >
          <BaseInput
            :label="$t('last_name')"
            type="text"
            :model-value="field.value"
            :error="errorMessage"
            required
            @update:model-value="field.onChange"
          />
        </Field>

        <Field
          v-slot="{ field, errorMessage }"
          name="email"
        >
          <BaseInput
            :label="$t('email')"
            type="email"
            :model-value="field.value"
            :error="errorMessage"
            required
            @update:model-value="field.onChange"
          />
        </Field>

        <Field
          v-slot="{ field, errorMessage }"
          name="username"
        >
          <BaseInput
            :label="$t('username')"
            type="text"
            :model-value="field.value"
            :error="errorMessage"
            required
            @update:model-value="field.onChange"
          />
        </Field>

        <Field
          v-slot="{ field, errorMessage }"
          name="phoneNumber"
        >
          <BaseInput
            :label="$t('phone_number')"
            type="tel"
            :model-value="field.value"
            :error="errorMessage"
            @update:model-value="field.onChange"
          />
        </Field>

        <!-- Company Selection -->
        <Field
          v-slot="{ field, errorMessage }"
          name="company_id"
        >
          <BaseInput
            :label="$t('company')"
            type="select"
            :model-value="field.value"
            :error="errorMessage"
            :placeholder="$t('select_company')"
            :options="companyOptions"
            @update:model-value="field.onChange"
          />
        </Field>

        <!-- Roles Selection -->
        <div>
          <label class="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-1">{{ $t('roles') }}</label>
          <div class="space-y-2">
            <div
              v-for="role in availableRoles"
              :key="role.id"
              class="flex items-center"
            >
              <Field
                v-slot="{ field, errorMessage }"
                :name="`roleIds[${role.id}]`"
                :value="role.id"
              >
                <BaseInput
                  type="checkbox"
                  :model-value="field.checked"
                  :checkbox-label="role.name"
                  :error="errorMessage"
                  @update:model-value="(value) => field.handleChange({ target: { checked: value } })"
                />
              </Field>
            </div>
          </div>
        </div>

        <!-- Password (only for create) -->
        <Field
          v-if="!isEditing"
          v-slot="{ field, errorMessage }"
          name="password"
        >
          <BaseInput
            :label="$t('password')"
            type="password"
            :model-value="field.value"
            :error="errorMessage"
            required
            @update:model-value="field.onChange"
          />
        </Field>

        <!-- Confirm Password (only for create) -->
        <Field
          v-if="!isEditing"
          v-slot="{ field, errorMessage }"
          name="confirmPassword"
        >
          <BaseInput
            :label="$t('confirm_password')"
            type="password"
            :model-value="field.value"
            :error="errorMessage"
            required
            @update:model-value="field.onChange"
          />
        </Field>

        <!-- All Access Checkbox -->
        <Field
          v-slot="{ field, errorMessage }"
          name="allAccess"
        >
          <BaseInput
            type="checkbox"
            :model-value="field.value"
            :checkbox-label="$t('all_access')"
            :error="errorMessage"
            @update:model-value="field.onChange"
          />
        </Field>
      </div>
      <div class="mt-6 pt-4 border-t border-slate-200 dark:border-slate-700 flex justify-end gap-3">
        <BaseButton
          type="button"
          color="secondary"
          color-type="no-border"
          :label="$t('cancel')"
          @click="handleClose"
        />

        <BaseButton
          type="submit"
          color="primary"
          :label="isEditing ? $t('update') : $t('create')"
        />
      </div>
    </Form>
  </BaseModal>
</template>

<script setup>
import { computed, ref, watch } from 'vue';
import { Field, Form } from 'vee-validate';
import { useI18n } from 'vue-i18n';
import { useUserValidationSchema } from '@/composables/useValidationSchemas';
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';
import BaseInput from '@/baseElements/BaseInput/BaseInput.vue';
import BaseModal from '@/baseElements/BaseModal/BaseModal.vue';

const { t } = useI18n();

const props = defineProps({
  companies: {
    default: () => [],
    type: Array
  },
  availableRoles: {
    default: () => [],
    type: Array
  },
  user: {
    default: null,
    type: Object
  },
  visible: {
    default: false,
    type: Boolean
  }
});

const emit = defineEmits(['close', 'submit']);

const isEditing = ref(false);

// Computed properties for select options
const companyOptions = computed(() => [
  ...props.companies.map(company => ({
    value: company.id,
    label: company.name
  }))
]);

const formData = ref({
  firstName: '',
  lastName: '',
  email: '',
  username: '',
  phoneNumber: '',
  company_id: '',
  roleIds: [],
  password: '',
  confirmPassword: '',
  allAccess: false
});

const validationSchema = computed(() => useUserValidationSchema(t, isEditing.value));

watch(() => props.user, (newUser) => {
  if (newUser) {
    isEditing.value = true;
    formData.value = {
      ...newUser,
      password: '',
      confirmPassword: '',
      roleIds: newUser.roles?.map(role => role.id) || [],
      company_id: newUser.company?.id || '',
      allAccess: newUser.allAccess || false,
      firstName: newUser.firstName || '',
      lastName: newUser.lastName || ''
    };
  } else {
    isEditing.value = false;
    formData.value = {
      firstName: '',
      lastName: '',
      email: '',
      username: '',
      phoneNumber: '',
      company_id: '',
      roleIds: [],
      password: '',
      confirmPassword: '',
      allAccess: false
    };
  }
}, { immediate: true });

const handleClose = () => {
  emit('close');
};

const handleSubmit = (values) => {
  emit('submit', values);
};
</script>

<i18n lang="yaml">
  en:
    edit_user: Edit User
    create_user: Create User
  fr:
    edit_user: Modifier l'utilisateur
    create_user: Créer un utilisateur
  mg:
    edit_user: Hanova ny mpampiasa
    create_user: Mamorona mpampiasa
  zh-CN:
    edit_user: 编辑用户
    create_user: 创建用户
</i18n>
