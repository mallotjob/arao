<template>
  <div class="space-y-6">
    <IndexHeader
      :title="t('users')"
      :description="t('manage_users_description')"
      :button-text="t('add_user')"
      @create="showCreateModal = true"
    />

    <!-- Users DataTable -->
    <DataTable
      :value="users"
      :lazy="true"
      :paginator="true"
      :rows="rows"
      :total-records="totalRecords"
      :loading="loading"
      data-key="id"
      filter-display="row"
      paginator-template="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink
          CurrentPageReport RowsPerPageDropdown"
      :rows-per-page-options="[10, 20, 50]"
      current-page-report-template="Showing {first} to {last} of {totalRecords} users"
      @page="onPage($event)"
      @sort="onSort($event)"
      @filter="onFilter($event)"
    >
      <template #header>
        <div class="flex flex-col gap-4">
          <h5 class="text-lg font-semibold text-slate-700">
            {{ t('users') }}
          </h5>
          <SearchFilter
            :search-placeholder="t('search_users')"
            :filters="[
              {
                label: 'role',
                model: roleFilter,
                options: [
                  { value: '', label: t('all_roles') },
                  { value: 'admin', label: t('admin') },
                  { value: 'manager', label: t('manager') },
                  { value: 'viewer', label: t('viewer') }
                ]
              },
              {
                label: 'company',
                model: companyFilter,
                options: [
                  { value: '', label: t('all_companies') },
                  ...companies.map(company => ({ value: company.id, label: company.name }))
                ]
              }
            ]"
            @update:search="onSearch"
            @update:filters="onFilterChange"
            @reset="resetFilters"
          />
        </div>
      </template>

      <template #empty>
        <div class="text-center py-8 text-slate-500">
          {{ t('no_users_found') }}
        </div>
      </template>

      <template #loading>
        <div class="text-center py-8 text-slate-500">
          {{ t('loading_users') }}
        </div>
      </template>

      <Column
        field="firstName"
        :header="t('user')"
        style="min-width: 16rem"
      >
        <template #body="{ data }">
          <div class="flex items-center">
            <div class="w-8 h-8 bg-blue-500 rounded-full flex items-center justify-center">
              <span class="text-sm font-medium text-white">{{ userInitials(data) }}</span>
            </div>
            <div class="ml-3">
              <div class="text-sm font-medium text-slate-900">
                {{ data.firstName }} {{ data.lastName }}
              </div>
              <div class="text-sm text-slate-500">
                @{{ data.username }}
              </div>
            </div>
          </div>
        </template>
      </Column>

      <Column
        field="email"
        :header="t('email')"
        style="min-width: 14rem"
      />

      <Column
        field="company.name"
        :header="t('company')"
        style="min-width: 12rem"
      >
        <template #body="{ data }">
          {{ data.company?.name || t('no_company') }}
        </template>
      </Column>

      <Column
        field="roles"
        :header="t('roles')"
        style="min-width: 12rem"
      >
        <template #body="{ data }">
          <div class="flex flex-wrap gap-1">
            <span
              v-for="role in data.roles"
              :key="role.id"
              class="px-2 py-1 text-xs rounded-full"
              :class="getRoleClass(role.name)"
            >
              {{ role.name }}
            </span>
          </div>
        </template>
      </Column>

      <Column
        field="status"
        :header="t('status')"
        style="min-width: 8rem"
      >
        <template #body>
          <span class="px-2 py-1 text-xs rounded-full bg-green-100 text-green-800">
            {{ t('active') }}
          </span>
        </template>
      </Column>

      <Column
        :header="t('actions')"
        style="min-width: 12rem"
      >
        <template #body="{ data }">
          <div class="flex gap-2">
            <button
              class="text-blue-600 hover:text-blue-900"
              @click="editUser(data)"
            >
              {{ t('edit') }}
            </button>
            <button
              class="text-purple-600 hover:text-purple-900"
              @click="manageRoles(data)"
            >
              {{ t('roles') }}
            </button>
            <button
              class="text-red-600 hover:text-red-900"
              @click="deleteUser(data)"
            >
              {{ t('delete') }}
            </button>
          </div>
        </template>
      </Column>
    </DataTable>

    <!-- Create/Edit Modal -->
    <UserModal
      :visible="showCreateModal || !!editingUser"
      :user="editingUser"
      :companies="companies"
      @close="closeModal"
      @submit="handleSaveUser"
    />

    <!-- Role Management Modal -->
    <RoleModal
      :visible="showRoleModal"
      :selected-user="selectedUser"
      :available-roles="availableRoles"
      @close="showRoleModal = false"
      @toggle-role="handleToggleRole"
    />
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useI18n } from 'vue-i18n';
import { useUsers } from '@/admin/composables/useUsers';
import IndexHeader from '@/admin/component/shared/IndexHeader.vue';
import RoleModal from '@/admin/component/user/RoleModal.vue';
import SearchFilter from '@/admin/component/shared/SearchFilter.vue';
import UserModal from '@/admin/component/user/UserModal.vue';

const { t } = useI18n();

const {
  users,
  companies,
  availableRoles,
  loading,
  totalRecords,
  rows,
  roleFilter,
  companyFilter,
  loadUsers,
  loadCompanies,
  loadRoles,
  onPage,
  onSort,
  onFilter,
  onSearch,
  onFilterChange,
  resetFilters,
  saveUser,
  deleteUser,
  toggleRole,
  userInitials,
  getRoleClass
} = useUsers();

const showCreateModal = ref(false);
const editingUser = ref(null);
const showRoleModal = ref(false);
const selectedUser = ref(null);

const editUser = (user) => {
  editingUser.value = user;
};

const closeModal = () => {
  showCreateModal.value = false;
  editingUser.value = null;
};

const handleSaveUser = async (userData) => {
  try {
    await saveUser(userData, editingUser.value);
    closeModal();
  } catch (error) {
    console.error('Error saving user:', error);
    // Error is already handled in the composable
  }
};

const manageRoles = (user) => {
  selectedUser.value = user;
  showRoleModal.value = true;
};

const handleToggleRole = async (user, roleName) => {
  try {
    await toggleRole(user, roleName);
  } catch (error) {
    console.error('Error toggling role:', error);
    // Error is already handled in the composable
  }
};

onMounted(() => {
  loadUsers();
  loadCompanies();
  loadRoles();
});
</script>

<i18n lang="yaml">
  en:
    users: Users
    manage_users_description: Manage user accounts and permissions
    add_user: Add User
    search_users: Search users...
    all_roles: All Roles
    admin: Admin
    manager: Manager
    viewer: Viewer
    all_companies: All Companies
    no_users_found: No users found.
    loading_users: Loading users data. Please wait.
    user: User
    email: Email
    company: Company
    roles: Roles
    status: Status
    actions: Actions
    no_company: No Company
    active: Active
    edit: Edit
    delete: Delete
  fr:
    users: Utilisateurs
    manage_users_description: Gérer les comptes utilisateurs et les permissions
    add_user: Ajouter un utilisateur
    search_users: Rechercher des utilisateurs...
    all_roles: Tous les rôles
    admin: Administrateur
    manager: Gestionnaire
    viewer: Lecteur
    all_companies: Toutes les entreprises
    no_users_found: Aucun utilisateur trouvé.
    loading_users: Chargement des données utilisateurs. Veuillez patienter.
    user: Utilisateur
    email: Email
    company: Entreprise
    roles: Rôles
    status: Statut
    actions: Actions
    no_company: Aucune entreprise
    active: Actif
    edit: Modifier
    delete: Supprimer
  mg:
    users: Mpampiasa
    manage_users_description: Hanoy ny kaonty mpampiasa sy ny alalana
    add_user: Ampidiro mpampiasa
    search_users: Karohy mpampiasa...
    all_roles: Ny anjara asa rehetra
    admin: Mpitandraisa
    manager: Mpanara-maso
    viewer: Mpanohana
    all_companies: Ny orinasa rehetra
    no_users_found: Tsy misy mpampiasa hita.
    loading_users: Mandefy ny angona mpampiasa. Azafady miandrasa.
    user: Mpampiasa
    email: Email
    company: Orinasa
    roles: Anjara asa
    status: Toerana
    actions: Asa
    no_company: Tsy misy orinasa
    active: Miasa
    edit: Hanova
    delete: Fafao
  zh-CN:
    users: 用户
    manage_users_description: 管理用户账户和权限
    add_user: 添加用户
    search_users: 搜索用户...
    all_roles: 所有角色
    admin: 管理员
    manager: 经理
    viewer: 查看者
    all_companies: 所有公司
    no_users_found: 未找到用户。
    loading_users: 正在加载用户数据。请稍候。
    user: 用户
    email: 邮箱
    company: 公司
    roles: 角色
    status: 状态
    actions: 操作
    no_company: 无公司
    active: 活跃
    edit: 编辑
    delete: 删除
</i18n>
