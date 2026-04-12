<template>
  <div
    v-if="visible"
    class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
  >
    <div class="bg-white rounded-lg p-6 w-full max-w-md">
      <h2 class="text-xl font-semibold mb-4">
        {{ isEditing ? t('edit_user') : t('create_user') }}
      </h2>
      <form @submit.prevent="handleSubmit">
        <div class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">{{ t('first_name') }}</label>
            <input
              v-model="formData.firstName"
              type="text"
              required
              class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
              focus:border-blue-500"
            >
          </div>
          <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">{{ t('last_name') }}</label>
            <input
              v-model="formData.lastName"
              type="text"
              required
              class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
              focus:border-blue-500"
            >
          </div>
          <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">{{ t('email') }}</label>
            <input
              v-model="formData.email"
              type="email"
              required
              class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
              focus:border-blue-500"
            >
          </div>
          <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">{{ t('username') }}</label>
            <input
              v-model="formData.username"
              type="text"
              required
              class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
               focus:border-blue-500"
            >
          </div>
          <div>
            <label class="block text-sm font-medium text-slate-700 mb-1">{{ t('company') }}</label>
            <select
              v-model="formData.company_id"
              class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
              focus:border-blue-500"
            >
              <option value="">
                {{ t('select_company') }}
              </option>
              <option
                v-for="company in companies"
                :key="company.id"
                :value="company.id"
              >
                {{ company.name }}
              </option>
            </select>
          </div>
          <div v-if="!isEditing">
            <label class="block text-sm font-medium text-slate-700 mb-1">{{ t('password') }}</label>
            <input
              v-model="formData.password"
              type="password"
              required
              class="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500
              focus:border-blue-500"
            >
          </div>
        </div>
        <div class="mt-6 flex justify-end space-x-3">
          <button
            type="button"
            class="px-4 py-2 text-slate-700 border border-slate-300 rounded-lg hover:bg-slate-50"
            @click="handleClose"
          >
            {{ t('cancel') }}
          </button>
          <button
            type="submit"
            class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
          >
            {{ isEditing ? t('update') : t('create') }}
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const props = defineProps({
  companies: {
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
const formData = ref({
  firstName: '',
  lastName: '',
  email: '',
  username: '',
  company_id: '',
  password: ''
});

watch(() => props.user, (newUser) => {
  if (newUser) {
    isEditing.value = true;
    formData.value = { ...newUser, password: '' };
  } else {
    isEditing.value = false;
    formData.value = {
      firstName: '',
      lastName: '',
      email: '',
      username: '',
      company_id: '',
      password: ''
    };
  }
}, { immediate: true });

const handleClose = () => {
  emit('close');
};

const handleSubmit = () => {
  emit('submit', formData.value);
};
</script>

<i18n lang="yaml">
  en:
    edit_user: Edit User
    create_user: Create User
    first_name: First Name
    last_name: Last Name
    email: Email
    username: Username
    company: Company
    select_company: Select Company
    password: Password
    cancel: Cancel
    update: Update
    create: Create
  fr:
    edit_user: Modifier l'utilisateur
    create_user: Créer un utilisateur
    first_name: Prénom
    last_name: Nom
    email: Email
    username: Nom d'utilisateur
    company: Entreprise
    select_company: Sélectionner une entreprise
    password: Mot de passe
    cancel: Annuler
    update: Mettre à jour
    create: Créer
  mg:
    edit_user: Hanova ny mpampiasa
    create_user: Mamorona mpampiasa
    first_name: Anaran'ny lehibe
    last_name: Anarana faharoa
    email: Email
    username: Anarana fampiasa
    company: Orinasa
    select_company: Misafidy orinasa
    password: Tenimiafina
    cancel: Atsaharo
    update: Havaozy
    create: Mamorona
  zh-CN:
    edit_user: 编辑用户
    create_user: 创建用户
    first_name: 名
    last_name: 姓
    email: 邮箱
    username: 用户名
    company: 公司
    select_company: 选择公司
    password: 密码
    cancel: 取消
    update: 更新
    create: 创建
</i18n>
