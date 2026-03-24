<template>
  <BaseCard
    :title="t('roles_and_permissions')"
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
              d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0
                  003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"
            />
          </svg>
          <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
            {{ t('current_roles') }}
          </label>
        </div>
        <div class="flex flex-wrap gap-2">
          <span
            v-for="role in currentUser.roles"
            :key="role.id"
            class="px-3 py-1 text-xs rounded-full font-medium"
            :class="getRoleClass(role.name)"
          >
            {{ role.name }}
          </span>
          <span
            v-if="!currentUser.roles || currentUser.roles.length === 0"
            class="text-sm text-slate-500 italic"
          >
            {{ t('no_roles_assigned') }}
          </span>
        </div>
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
              d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"
            />
          </svg>
          <label class="text-xs font-medium text-slate-600 dark:text-slate-300 uppercase tracking-wider">
            {{ t('highest_role') }}
          </label>
        </div>
        <p class="text-base font-medium text-slate-900 dark:text-white">
          {{ highestRole || t('none') }}
        </p>
      </BaseCard>
    </div>
  </BaseCard>
</template>
<script setup>
import { computed } from 'vue';
import { useI18n } from 'vue-i18n';
import BaseCard from '@/baseElements/BaseCard/BaseCard.vue';

const props = defineProps({
  currentUser: {
    type: Object,
    required: true
  }
});

const { t } = useI18n();

const highestRole = computed(() => {
  if (!props.currentUser.roles || props.currentUser.roles.length === 0) return t('none');

  const roleHierarchy = ['admin', 'manager', 'user'];
  const userRoles = props.currentUser.roles.map(r => r.name);

  for (const role of roleHierarchy) {
    if (userRoles.includes(role)) {
      return role.charAt(0).toUpperCase() + role.slice(1);
    }
  }
  return 'User';
});

const getRoleClass = (roleName) => {
  const roleClasses = {
    admin: 'bg-red-100 text-red-800',
    manager: 'bg-purple-100 text-purple-800',
    user: 'bg-blue-100 text-blue-800'
  };
  return roleClasses[roleName] || 'bg-gray-100 text-gray-800';
};
</script>

<i18n lang="yaml">
  en:
    roles_and_permissions: Roles & Permissions
    current_roles: Current Roles
    highest_role: Highest Role
    no_roles_assigned: No roles assigned
    none: None
  fr:
    roles_and_permissions: Rôles & Permissions
    current_roles: Rôles Actuels
    highest_role: Rôle le Plus Haut
    no_roles_assigned: Aucun rôle assigné
    none: Aucun
  mg:
    roles_and_permissions: Andraikitra & Fahazo
    current_roles: Andraikitra Ankehitriny
    highest_role: Andraikitra lehibe indrindra
    no_roles_assigned: Tsy misy andraikitra voatanisa
    none: Tsy misy
  zh-CN:
    roles_and_permissions: 角色和权限
    current_roles: 当前角色
    highest_role: 最高角色
    no_roles_assigned: 没有分配角色
    none: 无
</i18n>
