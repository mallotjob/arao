import { computed, reactive, ref } from 'vue';
import { getNotificationType } from '@/shared/config/notificationConfig';

// Global notification state
const notifications = reactive(new Map());
const notificationId = ref(0);
const maxNotifications = 10; // Maximum notifications to prevent overwhelming

// Generate unique ID for notifications
const generateId = () => {
  return `notification-${++notificationId.value}`;
};

// Cleanup old notifications if we exceed max
const cleanupOldNotifications = () => {
  if (notifications.size >= maxNotifications) {
    const oldestId = notifications.keys().next().value;
    notifications.delete(oldestId);
  }
};

// Core notification function
export const showNotification = (options) => {
  const {
    message,
    title = '',
    type = 'info',
    variant = 'solid',
    component = 'toast',
    duration,
    position,
    closable = true,
    persistent = false,
    showProgress = true,
    actions = null,
    actionProps = {},
    ...otherOptions
  } = options;

  // Get type configuration
  const typeConfig = getNotificationType(type);
  const id = generateId();

  // Determine duration
  const finalDuration = duration ?? typeConfig.duration;

  const notification = {
    id,
    message,
    title,
    type: typeConfig.id,
    variant,
    component,
    duration: finalDuration,
    position: position || 'top-right',
    closable,
    persistent,
    showProgress,
    actions,
    actionProps,
    timestamp: Date.now(),
    ...otherOptions
  };

  // Add to state
  notifications.set(id, notification);

  // Cleanup if needed
  cleanupOldNotifications();

  // Auto-remove notification if not persistent
  if (!persistent && finalDuration > 0) {
    setTimeout(() => {
      if (notifications.has(id)) {
        notifications.delete(id);
      }
    }, finalDuration);
  }

  return id;
};

// Convenience methods for different notification types
export const showSuccess = (message, options = {}) => {
  return showNotification({
    message,
    type: 'success',
    ...options
  });
};

export const showError = (message, options = {}) => {
  return showNotification({
    message,
    type: 'error',
    ...options
  });
};

export const showWarning = (message, options = {}) => {
  return showNotification({
    message,
    type: 'warning',
    ...options
  });
};

export const showInfo = (message, options = {}) => {
  return showNotification({
    message,
    type: 'info',
    ...options
  });
};

export const showLoading = (message, options = {}) => {
  return showNotification({
    message,
    type: 'loading',
    persistent: true,
    closable: false,
    showProgress: false,
    ...options
  });
};

// Toast-specific convenience methods
export const showToast = (message, options = {}) => {
  return showNotification({
    message,
    component: 'toast',
    showProgress: true,
    ...options
  });
};

export const showSuccessToast = (message, options = {}) => {
  return showNotification({
    message,
    type: 'success',
    component: 'toast',
    showProgress: true,
    ...options
  });
};

export const showErrorToast = (message, options = {}) => {
  return showNotification({
    message,
    type: 'error',
    component: 'toast',
    showProgress: true,
    ...options
  });
};

export const showWarningToast = (message, options = {}) => {
  return showNotification({
    message,
    type: 'warning',
    component: 'toast',
    showProgress: true,
    ...options
  });
};

export const showInfoToast = (message, options = {}) => {
  return showNotification({
    message,
    type: 'info',
    component: 'toast',
    showProgress: true,
    ...options
  });
};

// Alert-specific convenience methods
export const showAlert = (message, options = {}) => {
  return showNotification({
    message,
    component: 'alert',
    persistent: true,
    ...options
  });
};

export const showSuccessAlert = (message, options = {}) => {
  return showNotification({
    message,
    type: 'success',
    component: 'alert',
    persistent: true,
    ...options
  });
};

export const showErrorAlert = (message, options = {}) => {
  return showNotification({
    message,
    type: 'error',
    component: 'alert',
    persistent: true,
    ...options
  });
};

export const showWarningAlert = (message, options = {}) => {
  return showNotification({
    message,
    type: 'warning',
    component: 'alert',
    persistent: true,
    ...options
  });
};

export const showInfoAlert = (message, options = {}) => {
  return showNotification({
    message,
    type: 'info',
    component: 'alert',
    persistent: true,
    ...options
  });
};

// Remove a specific notification
export const removeNotification = (id) => {
  notifications.delete(id);
};

// Clear all notifications
export const clearNotifications = () => {
  notifications.clear();
};

// Clear notifications by type
export const clearNotificationsByType = (type) => {
  for (const [id, notification] of notifications) {
    if (notification.type === type) {
      notifications.delete(id);
    }
  }
};

// Clear notifications by component
export const clearNotificationsByComponent = (component) => {
  for (const [id, notification] of notifications) {
    if (notification.component === component) {
      notifications.delete(id);
    }
  }
};

// Hide all loading notifications
export const hideLoadingNotifications = () => {
  for (const [id, notification] of notifications) {
    if (notification.type === 'loading') {
      notifications.delete(id);
    }
  }
};

// Handle flash messages from server
export const handleFlashMessages = (flashData) => {
  if (!flashData) return;

  // Clear existing flash notifications first
  clearNotificationsByType('success');
  clearNotificationsByType('error');
  clearNotificationsByType('warning');
  clearNotificationsByType('info');

  // Show new flash messages
  Object.entries(flashData).forEach(([key, messages]) => {
    if (!messages) return;

    const messageArray = Array.isArray(messages) ? messages : [messages];

    messageArray.forEach(message => {
      const type = key === 'notice' ? 'success' :
        key === 'alert' ? 'error' :
          key === 'warning' ? 'warning' : 'info';

      showNotification({
        message,
        type,
        component: 'toast',
        showProgress: true
      });
    });
  });
};

// Get notifications by component type
export const getNotificationsByComponent = (component) => {
  return Array.from(notifications.values()).filter(n => n.component === component);
};

// Get notifications by position
export const getNotificationsByPosition = (position) => {
  return Array.from(notifications.values()).filter(n => n.position === position);
};

// Reactive computed properties
export const allNotifications = computed(() => Array.from(notifications.values()));
export const toastNotifications = computed(() => getNotificationsByComponent('toast'));
export const alertNotifications = computed(() => getNotificationsByComponent('alert'));
export const loadingNotifications = computed(() => Array.from(notifications.values()).filter(n => n.type === 'loading'));

// Main composable export
export const useNotificationSystem = () => {
  return {
    // State
    notifications: allNotifications,
    toastNotifications,
    alertNotifications,
    loadingNotifications,

    // Core methods
    showNotification,
    removeNotification,
    clearNotifications,
    clearNotificationsByType,
    clearNotificationsByComponent,

    // Type-specific methods
    showSuccess,
    showError,
    showWarning,
    showInfo,
    showLoading,

    // Toast methods
    showToast,
    showSuccessToast,
    showErrorToast,
    showWarningToast,
    showInfoToast,

    // Alert methods
    showAlert,
    showSuccessAlert,
    showErrorAlert,
    showWarningAlert,
    showInfoAlert,

    // Utility methods
    hideLoadingNotifications,
    handleFlashMessages,
    getNotificationsByComponent,
    getNotificationsByPosition
  };
};

// Export the reactive map for direct access in templates
export { notifications as notificationList };

