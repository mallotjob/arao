// Notification system configuration
export const NOTIFICATION_TYPES = {
  SUCCESS: {
    id: 'success',
    name: 'Success',
    icon: 'circle-check',
    color: 'green',
    duration: 4000,
    persistent: false,
    showProgress: true,
    closable: true,
    variant: 'solid'
  },
  ERROR: {
    id: 'error',
    name: 'Error',
    icon: 'circle-exclamation',
    color: 'red',
    duration: 6000,
    persistent: false,
    showProgress: true,
    closable: true,
    variant: 'solid'
  },
  WARNING: {
    id: 'warning',
    name: 'Warning',
    icon: 'triangle-exclamation',
    color: 'yellow',
    duration: 5000,
    persistent: false,
    showProgress: true,
    closable: true,
    variant: 'solid'
  },
  INFO: {
    id: 'info',
    name: 'Info',
    icon: 'circle-info',
    color: 'blue',
    duration: 3000,
    persistent: false,
    showProgress: true,
    closable: true,
    variant: 'solid'
  },
  LOADING: {
    id: 'loading',
    name: 'Loading',
    icon: 'circle-notch',
    color: 'slate',
    duration: 0,
    persistent: true,
    showProgress: false,
    closable: false,
    variant: 'solid'
  }
};

export const NOTIFICATION_VARIANTS = {
  SOLID: {
    id: 'solid',
    name: 'Solid',
    background: true,
    border: true,
    shadow: true
  },
  OUTLINE: {
    id: 'outline',
    name: 'Outline',
    background: false,
    border: true,
    shadow: true
  },
  MINIMAL: {
    id: 'minimal',
    name: 'Minimal',
    background: false,
    border: false,
    shadow: false
  }
};

export const NOTIFICATION_POSITIONS = {
  TOP_LEFT: 'top-left',
  TOP_RIGHT: 'top-right',
  BOTTOM_LEFT: 'bottom-left',
  BOTTOM_RIGHT: 'bottom-right',
  TOP_CENTER: 'top-center',
  BOTTOM_CENTER: 'bottom-center'
};

export const NOTIFICATION_COMPONENTS = {
  TOAST: 'toast',
  ALERT: 'alert',
  BANNER: 'banner',
  MODAL: 'modal'
};

// Helper functions
export const getNotificationType = (type) => {
  return NOTIFICATION_TYPES[type.toUpperCase()] || NOTIFICATION_TYPES.INFO;
};

export const getNotificationVariant = (variant) => {
  return NOTIFICATION_VARIANTS[variant.toUpperCase()] || NOTIFICATION_VARIANTS.SOLID;
};

export const getColorClasses = (color, variant, isDark = false) => {
  const colors = {
    green: {
      solid: {
        bg: isDark ? 'bg-green-900/90' : 'bg-green-50',
        border: isDark ? 'border-green-700' : 'border-green-200',
        text: isDark ? 'text-green-200' : 'text-green-800',
        icon: isDark ? 'text-green-400' : 'text-green-600'
      },
      outline: {
        bg: isDark ? 'bg-slate-800' : 'bg-white',
        border: isDark ? 'border-green-600' : 'border-green-300',
        text: isDark ? 'text-green-300' : 'text-green-700',
        icon: isDark ? 'text-green-400' : 'text-green-500'
      },
      minimal: {
        bg: isDark ? 'bg-green-950/50' : 'bg-green-50/50',
        border: 'border-transparent',
        text: isDark ? 'text-green-300' : 'text-green-700',
        icon: isDark ? 'text-green-400' : 'text-green-500'
      }
    },
    red: {
      solid: {
        bg: isDark ? 'bg-red-900/90' : 'bg-red-50',
        border: isDark ? 'border-red-700' : 'border-red-200',
        text: isDark ? 'text-red-200' : 'text-red-800',
        icon: isDark ? 'text-red-400' : 'text-red-600'
      },
      outline: {
        bg: isDark ? 'bg-slate-800' : 'bg-white',
        border: isDark ? 'border-red-600' : 'border-red-300',
        text: isDark ? 'text-red-300' : 'text-red-700',
        icon: isDark ? 'text-red-400' : 'text-red-500'
      },
      minimal: {
        bg: isDark ? 'bg-red-950/50' : 'bg-red-50/50',
        border: 'border-transparent',
        text: isDark ? 'text-red-300' : 'text-red-700',
        icon: isDark ? 'text-red-400' : 'text-red-500'
      }
    },
    yellow: {
      solid: {
        bg: isDark ? 'bg-yellow-900/90' : 'bg-yellow-50',
        border: isDark ? 'border-yellow-700' : 'border-yellow-200',
        text: isDark ? 'text-yellow-200' : 'text-yellow-800',
        icon: isDark ? 'text-yellow-400' : 'text-yellow-600'
      },
      outline: {
        bg: isDark ? 'bg-slate-800' : 'bg-white',
        border: isDark ? 'border-yellow-600' : 'border-yellow-300',
        text: isDark ? 'text-yellow-300' : 'text-yellow-700',
        icon: isDark ? 'text-yellow-400' : 'text-yellow-500'
      },
      minimal: {
        bg: isDark ? 'bg-yellow-950/50' : 'bg-yellow-50/50',
        border: 'border-transparent',
        text: isDark ? 'text-yellow-300' : 'text-yellow-700',
        icon: isDark ? 'text-yellow-400' : 'text-yellow-500'
      }
    },
    blue: {
      solid: {
        bg: isDark ? 'bg-blue-900/90' : 'bg-blue-50',
        border: isDark ? 'border-blue-700' : 'border-blue-200',
        text: isDark ? 'text-blue-200' : 'text-blue-800',
        icon: isDark ? 'text-blue-400' : 'text-blue-600'
      },
      outline: {
        bg: isDark ? 'bg-slate-800' : 'bg-white',
        border: isDark ? 'border-blue-600' : 'border-blue-300',
        text: isDark ? 'text-blue-300' : 'text-blue-700',
        icon: isDark ? 'text-blue-400' : 'text-blue-500'
      },
      minimal: {
        bg: isDark ? 'bg-blue-950/50' : 'bg-blue-50/50',
        border: 'border-transparent',
        text: isDark ? 'text-blue-300' : 'text-blue-700',
        icon: isDark ? 'text-blue-400' : 'text-blue-500'
      }
    },
    slate: {
      solid: {
        bg: isDark ? 'bg-slate-800' : 'bg-slate-100',
        border: isDark ? 'border-slate-600' : 'border-slate-300',
        text: isDark ? 'text-slate-200' : 'text-slate-800',
        icon: isDark ? 'text-slate-400' : 'text-slate-600'
      },
      outline: {
        bg: isDark ? 'bg-slate-800' : 'bg-white',
        border: isDark ? 'border-slate-600' : 'border-slate-300',
        text: isDark ? 'text-slate-300' : 'text-slate-700',
        icon: isDark ? 'text-slate-400' : 'text-slate-500'
      },
      minimal: {
        bg: isDark ? 'bg-slate-900/50' : 'bg-slate-50/50',
        border: 'border-transparent',
        text: isDark ? 'text-slate-300' : 'text-slate-700',
        icon: isDark ? 'text-slate-400' : 'text-slate-500'
      }
    }
  };

  return colors[color]?.[variant] || colors.blue.solid;
};
