<template>
  <div class="min-h-screen bg-slate-50 dark:bg-slate-950 flex">
    <!-- Sidebar -->
    <Sidebar :sidebar-open="sidebarOpen" />

    <!-- Main Content -->
    <div class="w-full">
      <Header @toggle-sidebar="toggleSidebar" />

      <!-- Page Content -->
      <main class="p-4 sm:p-6 lg:p-8 bg-slate-50 dark:bg-slate-950 h-[calc(100vh-4.5rem)] overflow-y-auto">
        <router-view />
      </main>
    </div>

    <!-- Mobile sidebar overlay -->
    <div
      v-if="sidebarOpen"
      class="fixed inset-0 bg-slate-600/75 dark:bg-black/70 z-40 lg:hidden"
      @click="toggleSidebar"
    />

    <!-- Global Notification System -->
    <NotificationSystem />
  </div>
</template>

<script setup>
import { ref } from 'vue';
import Header from '@/admin/layouts/Header.vue';
import NotificationSystem from '@/baseElements/NotificationSystem/NotificationSystem.vue';
import Sidebar from '@/admin/layouts/Sidebar.vue';

const sidebarOpen = ref(false);

// Methods
const toggleSidebar = () => {
  sidebarOpen.value = !sidebarOpen.value;
};
</script>
