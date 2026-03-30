<template>
  <Teleport to="body">
    <!-- Toast Container -->
    <div class="notification-system">
      <!-- Top Left -->
      <div class="notification-zone notification-zone--top-left">
        <BaseToast
          v-for="notification in notificationsByPosition['top-left']"
          :id="notification.id"
          :key="notification.id"
          :message="notification.message"
          :title="notification.title"
          :type="notification.type"
          :variant="notification.variant"
          :duration="notification.duration"
          :persistent="notification.persistent"
          :show-progress="notification.showProgress"
          :closable="notification.closable"
          :position="notification.position"
          @close="removeNotification(notification.id)"
        />
      </div>

      <!-- Top Right -->
      <div class="notification-zone notification-zone--top-right">
        <BaseToast
          v-for="notification in notificationsByPosition['top-right']"
          :id="notification.id"
          :key="notification.id"
          :message="notification.message"
          :title="notification.title"
          :type="notification.type"
          :variant="notification.variant"
          :duration="notification.duration"
          :persistent="notification.persistent"
          :show-progress="notification.showProgress"
          :closable="notification.closable"
          :position="notification.position"
          @close="removeNotification(notification.id)"
        />
      </div>

      <!-- Top Center -->
      <div class="notification-zone notification-zone--top-center">
        <BaseToast
          v-for="notification in notificationsByPosition['top-center']"
          :id="notification.id"
          :key="notification.id"
          :message="notification.message"
          :title="notification.title"
          :type="notification.type"
          :variant="notification.variant"
          :duration="notification.duration"
          :persistent="notification.persistent"
          :show-progress="notification.showProgress"
          :closable="notification.closable"
          :position="notification.position"
          @close="removeNotification(notification.id)"
        />
      </div>

      <!-- Bottom Left -->
      <div class="notification-zone notification-zone--bottom-left">
        <BaseToast
          v-for="notification in notificationsByPosition['bottom-left']"
          :id="notification.id"
          :key="notification.id"
          :message="notification.message"
          :title="notification.title"
          :type="notification.type"
          :variant="notification.variant"
          :duration="notification.duration"
          :persistent="notification.persistent"
          :show-progress="notification.showProgress"
          :closable="notification.closable"
          :position="notification.position"
          @close="removeNotification(notification.id)"
        />
      </div>

      <!-- Bottom Right -->
      <div class="notification-zone notification-zone--bottom-right">
        <BaseToast
          v-for="notification in notificationsByPosition['bottom-right']"
          :id="notification.id"
          :key="notification.id"
          :message="notification.message"
          :title="notification.title"
          :type="notification.type"
          :variant="notification.variant"
          :duration="notification.duration"
          :persistent="notification.persistent"
          :show-progress="notification.showProgress"
          :closable="notification.closable"
          :position="notification.position"
          @close="removeNotification(notification.id)"
        />
      </div>

      <!-- Bottom Center -->
      <div class="notification-zone notification-zone--bottom-center">
        <BaseToast
          v-for="notification in notificationsByPosition['bottom-center']"
          :id="notification.id"
          :key="notification.id"
          :message="notification.message"
          :title="notification.title"
          :type="notification.type"
          :variant="notification.variant"
          :duration="notification.duration"
          :persistent="notification.persistent"
          :show-progress="notification.showProgress"
          :closable="notification.closable"
          :position="notification.position"
          @close="removeNotification(notification.id)"
        />
      </div>
    </div>
  </Teleport>
</template>

<script setup>
import { computed } from 'vue';
import { useNotificationSystem } from '@/composables/useNotificationSystem';
import BaseToast from '@/baseElements/BaseToast/BaseToast.vue';

const { notifications, removeNotification } = useNotificationSystem();

// Group notifications by position
const notificationsByPosition = computed(() => {
  const positions = {
    'top-left': [],
    'top-right': [],
    'top-center': [],
    'bottom-left': [],
    'bottom-right': [],
    'bottom-center': []
  };

  notifications.value.forEach(notification => {
    const position = notification.position || 'top-right';
    if (positions[position]) {
      positions[position].push(notification);
    }
  });

  return positions;
});
</script>

<style lang="scss" scoped>
.notification-system {
  @apply pointer-events-none fixed inset-0 z-50;

  // Ensure notifications don't interfere with other elements
  .notification-zone {
    @apply pointer-events-none fixed;

    // Position styles
    &--top-left {
      @apply top-4 left-4;
    }

    &--top-right {
      @apply top-4 right-4;
    }

    &--top-center {
      @apply top-4 left-1/2 -translate-x-1/2;
    }

    &--bottom-left {
      @apply bottom-4 left-4;
    }

    &--bottom-right {
      @apply bottom-4 right-4;
    }

    &--bottom-center {
      @apply bottom-4 left-1/2 -translate-x-1/2;
    }

    // Space between notifications
    & > :deep(:not(:last-child)) {
      @apply mb-2;
    }
  }
}
</style>
