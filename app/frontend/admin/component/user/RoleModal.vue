<template>
  <div
    v-if="visible"
    class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
  >
    <div class="bg-white rounded-lg p-6 w-full max-w-md">
      <h2 class="text-xl font-semibold mb-4">
        {{ t('manage_roles') }} - {{ selectedUser?.firstName }} {{ selectedUser?.lastName }}
      </h2>
      <div class="space-y-3">
        <label
          v-for="role in availableRoles"
          :key="role.id"
          class="flex items-center"
        >
          <input
            type="checkbox"
            :checked="hasRole(selectedUser, role.name)"
            class="mr-3 h-4 w-4 text-blue-600 focus:ring-blue-500 border-slate-300 rounded"
            @change="toggleRole(selectedUser, role.name)"
          >
          <div>
            <div class="font-medium">{{ role.name }}</div>
            <div class="text-sm text-slate-500">{{ role.description }}</div>
          </div>
        </label>
      </div>
      <div class="mt-6 flex justify-end space-x-3">
        <button
          class="px-4 py-2 text-slate-700 border border-slate-300 rounded-lg hover:bg-slate-50"
          @click="handleClose"
        >
          {{ t('close') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

defineProps({
  visible: {
    type: Boolean,
    default: false
  },
  selectedUser: {
    type: Object,
    default: null
  },
  availableRoles: {
    type: Array,
    default: () => []
  }
});

const emit = defineEmits(['close', 'toggle-role']);

const hasRole = (user, roleName) => {
  return user.roles.some(role => role.name === roleName);
};

const toggleRole = (user, roleName) => {
  emit('toggle-role', user, roleName);
};

const handleClose = () => {
  emit('close');
};
</script>

<i18n lang="yaml">
  en:
    manage_roles: Manage Roles
    close: Close
  fr:
    manage_roles: Gérer les rôles
    close: Fermer
  mg:
    manage_roles: Hanoy ny anjara asa
    close: Hidio
  zh-CN:
    manage_roles: 管理角色
    close: 关闭
</i18n>
