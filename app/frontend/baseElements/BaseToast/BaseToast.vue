<template>
  <Transition
    :name="transitionName"
    appear
    @before-enter="onBeforeEnter"
    @enter="onEnter"
    @after-enter="onAfterEnter"
    @before-leave="onBeforeLeave"
    @leave="onLeave"
    @after-leave="onAfterLeave"
  >
    <div
      v-if="show"
      :class="containerClasses"
      :style="containerStyles"
      role="status"
      :aria-live="ariaLive"
      :data-notification-id="id"
    >
      <!-- Toast Content -->
      <div class="toast-content">
        <!-- Icon -->
        <div
          v-if="config.icon"
          class="toast-icon"
        >
          <FontAwesomeIcon
            :icon="['fas', config.icon || 'circle-info']"
            :class="iconClasses"
          />
        </div>

        <!-- Message -->
        <div class="toast-message">
          <div
            v-if="title"
            class="toast-title"
          >
            {{ title }}
          </div>
          <div class="toast-text">
            {{ message }}
          </div>
        </div>

        <!-- Progress bar for auto-dismiss -->
        <div
          v-if="showProgress && !persistent && duration > 0"
          class="toast-progress"
          :style="progressStyles"
        />

        <!-- Close button -->
        <BaseButton
          v-if="closable"
          color="secondary"
          color-type="no-border"
          class="absolute top-2 right-2"
          icon-position="center"
          size="sm"
          icon="xmark"
          :aria-label="closeAriaLabel"
          @click="close()"
        />
      </div>
    </div>
  </Transition>
</template>

<script setup>
import { computed, onMounted, onUnmounted, ref, watch } from 'vue';
import { getColorClasses, getNotificationType } from '@/config/notificationConfig';
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';

const props = defineProps({
  // Core content
  id: {
    type: String,
    required: true
  },
  message: {
    type: String,
    required: true
  },
  title: {
    type: String,
    default: ''
  },

  // Type and appearance
  type: {
    type: String,
    default: 'info',
    validator: value => ['success', 'error', 'warning', 'info', 'loading'].includes(value)
  },
  variant: {
    type: String,
    default: 'solid',
    validator: value => ['solid', 'outline', 'minimal'].includes(value)
  },

  // Behavior
  closable: {
    type: Boolean,
    default: true
  },
  persistent: {
    type: Boolean,
    default: false
  },
  duration: {
    type: Number,
    default: 4000
  },
  showProgress: {
    type: Boolean,
    default: true
  },

  // Positioning
  position: {
    type: String,
    default: 'top-right',
    validator: value => ['top-left', 'top-right', 'bottom-left', 'bottom-right', 'top-center', 'bottom-center'].includes(value)
  },

  // Accessibility
  ariaLive: {
    type: String,
    default: 'polite'
  },
  closeAriaLabel: {
    type: String,
    default: 'Close toast'
  }
});

const emit = defineEmits(['close']);

// State
const show = ref(false);
const timeoutId = ref(null);
const progress = ref(100);
const progressInterval = ref(null);

// Computed properties
const config = computed(() => {
  const typeConfig = getNotificationType(props.type);
  return {
    ...typeConfig,
    ...props
  };
});

const containerClasses = computed(() => {
  const isDark = typeof window !== 'undefined' && window.matchMedia('(prefers-color-scheme: dark)').matches;
  const finalColorClasses = getColorClasses(config.value.color, props.variant, isDark);

  return [
    'base-toast',
    `base-toast--${props.type}`,
    `base-toast--${props.variant}`,
    `base-toast--${props.position}`,
    {
      'base-toast--closable': props.closable,
      'base-toast--persistent': props.persistent,
      'base-toast--has-progress': props.showProgress && !props.persistent && props.duration > 0
    },
    finalColorClasses.bg,
    finalColorClasses.border,
    finalColorClasses.text
  ];
});

const containerStyles = computed(() => {
  const positionStyles = {
    'top-left': { top: '20px', left: '20px' },
    'top-right': { top: '20px', right: '20px' },
    'bottom-left': { bottom: '20px', left: '20px' },
    'bottom-right': { bottom: '20px', right: '20px' },
    'top-center': { top: '20px', left: '50%', transform: 'translateX(-50%)' },
    'bottom-center': { bottom: '20px', left: '50%', transform: 'translateX(-50%)' }
  };

  const baseStyle = positionStyles[props.position] || positionStyles['top-right'];

  // Override transform for center positions during transitions
  if (props.position.includes('center') && show.value) {
    return { ...baseStyle, transform: 'translateX(-50%)' };
  }

  return baseStyle;
});

const iconClasses = computed(() => {
  const isDark = typeof window !== 'undefined' && window.matchMedia('(prefers-color-scheme: dark)').matches;
  const colorClasses = getColorClasses(config.value.color, props.variant, isDark);

  return 'toast-icon__icon ' + colorClasses.icon;
});

const progressStyles = computed(() => ({
  width: `${progress.value}%`
}));

const transitionName = computed(() => {
  const positionTransitions = {
    'top-left': 'toast-slide-left',
    'top-right': 'toast-slide-right',
    'bottom-left': 'toast-slide-up-left',
    'bottom-right': 'toast-slide-up-right',
    'top-center': 'toast-slide-down',
    'bottom-center': 'toast-slide-up'
  };

  return positionTransitions[props.position] || 'toast-slide-right';
});

// Methods
const close = () => {
  show.value = false;
  emit('close');
};

const startTimer = () => {
  if (props.persistent || props.duration <= 0) return;

  timeoutId.value = setTimeout(() => {
    close();
  }, props.duration);

  // Start progress animation
  if (props.showProgress) {
    const interval = 50; // Update every 50ms
    const decrement = (interval / props.duration) * 100;

    progressInterval.value = setInterval(() => {
      progress.value = Math.max(0, progress.value - decrement);
    }, interval);
  }
};

const clearTimer = () => {
  if (timeoutId.value) {
    clearTimeout(timeoutId.value);
    timeoutId.value = null;
  }

  if (progressInterval.value) {
    clearInterval(progressInterval.value);
    progressInterval.value = null;
  }

  progress.value = 100;
};

// Transition hooks
const onBeforeEnter = (el) => {
  if (props.position.includes('left')) {
    el.style.transform = 'translateX(-100%)';
  } else if (props.position.includes('right')) {
    el.style.transform = 'translateX(100%)';
  } else if (props.position.includes('top')) {
    el.style.transform = 'translateY(-100%)';
  } else {
    el.style.transform = 'translateY(100%)';
  }
  el.style.opacity = '0';
};

const onEnter = (el) => {
  el.style.transition = 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)';
  el.style.transform = props.position.includes('center') ? 'translateX(-50%)' : 'translateX(0)';
  el.style.opacity = '1';
};

const onAfterEnter = (el) => {
  el.style.transition = '';
  el.style.transform = '';
};

const onBeforeLeave = (el) => {
  el.style.transform = props.position.includes('center') ? 'translateX(-50%)' : 'translateX(0)';
  el.style.opacity = '1';
};

const onLeave = (el) => {
  el.style.transition = 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)';
  if (props.position.includes('left')) {
    el.style.transform = 'translateX(-100%)';
  } else if (props.position.includes('right')) {
    el.style.transform = 'translateX(100%)';
  } else if (props.position.includes('top')) {
    el.style.transform = 'translateY(-100%)';
  } else {
    el.style.transform = 'translateY(100%)';
  }
  el.style.opacity = '0';
};

const onAfterLeave = (el) => {
  el.style.transition = '';
  el.style.transform = '';
};

// Lifecycle
onMounted(() => {
  show.value = true;
  startTimer();
});

onUnmounted(() => {
  clearTimer();
});

// Watch for changes to restart timer
watch([() => props.duration, () => props.persistent, () => props.showProgress], () => {
  clearTimer();
  if (show.value) {
    startTimer();
  }
}, { immediate: false });
</script>

<style lang="scss" scoped>
.base-toast {
  @apply fixed z-50 max-w-sm w-full pointer-events-auto rounded-lg shadow-lg;
  @apply backdrop-blur-sm transition-all duration-300;

  // Base styling
  &--solid {
    @apply border-2;
  }

  &--outline {
    @apply border-2 bg-white dark:bg-slate-800;
  }

  &--minimal {
    @apply border-0 shadow-md;
  }

  // Content styling
  .toast-content {
    @apply relative flex items-center p-4;
  }

  .toast-icon {
    @apply flex-shrink-0 mr-3;

    &__icon {
      @apply text-lg;
    }
  }

  .toast-message {
    @apply flex-1 min-w-0;
  }

  .toast-title {
    @apply font-semibold text-sm mb-1;
  }

  .toast-text {
    @apply text-sm leading-relaxed;
  }

  // Progress bar
  .toast-progress {
    @apply absolute bottom-0 left-0 h-1 bg-current opacity-30 rounded-b-lg;
    transition: width 0.05s linear;
  }

  // Has progress indicator (adjust close button position)
  &--has-progress {
    .toast-close {
      @apply top-3 right-3;
    }
  }
}

// Transitions
.toast-slide-right-enter-active,
.toast-slide-right-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.toast-slide-right-enter-from {
  transform: translateX(100%);
  opacity: 0;
}

.toast-slide-right-leave-to {
  transform: translateX(100%);
  opacity: 0;
}

.toast-slide-left-enter-active,
.toast-slide-left-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.toast-slide-left-enter-from {
  transform: translateX(-100%);
  opacity: 0;
}

.toast-slide-left-leave-to {
  transform: translateX(-100%);
  opacity: 0;
}

.toast-slide-up-enter-active,
.toast-slide-up-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.toast-slide-up-enter-from {
  transform: translateY(100%);
  opacity: 0;
}

.toast-slide-up-leave-to {
  transform: translateY(100%);
  opacity: 0;
}

.toast-slide-down-enter-active,
.toast-slide-down-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.toast-slide-down-enter-from {
  transform: translateY(-100%);
  opacity: 0;
}

.toast-slide-down-leave-to {
  transform: translateY(-100%);
  opacity: 0;
}

// Position-specific transitions
.toast-slide-up-right-enter-active,
.toast-slide-up-right-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.toast-slide-up-right-enter-from {
  transform: translateY(100%);
  opacity: 0;
}

.toast-slide-up-right-leave-to {
  transform: translateY(100%);
  opacity: 0;
}

.toast-slide-up-left-enter-active,
.toast-slide-up-left-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.toast-slide-up-left-enter-from {
  transform: translateY(100%);
  opacity: 0;
}

.toast-slide-up-left-leave-to {
  transform: translateY(100%);
  opacity: 0;
}
</style>
