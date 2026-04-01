<template>
  <button
    v-tooltip.bottom="tooltip || title || label"
    class="button"
    :class="{
      ['button-color-' + color]: color,
      ['button-' + colorType]: colorType,
      ['size-' + size]: size,
      ['width-' + width]: width,
      'round': round,
      'disabled': disabled || loading,
      'icon-only': !label && icon
    }"
    :disabled="disabled || loading"
    :type="computedType"
    :aria-label="ariaLabel || label"
    :title="title || label"
    @click="handleClick"
  >
    <slot v-if="useSlotAPI" />
    <span
      v-if="!useSlotAPI"
      ref="buttonPropsAPI"
      :class="{
        ['button-icon']: icon,
        ['button-icon-' + iconPosition]: iconPosition,
        'button-icon-loading': loading,
        'no-wrap': noWrap
      }"
    >
      <span
        v-if="icon || loading"
        class="icon"
        :class="{
          ['icon-size-' + size]: !label
        }"
      >
        <FontAwesomeIcon
          v-if="!loading"
          :icon="['fas', icon]"
        />
        <BaseSpinner
          v-if="loading"
          color="light"
          size="xs"
        />
      </span>
      {{ label }}
    </span>
  </button>
</template>

<script setup>
import { computed, useSlots } from 'vue';
import BaseSpinner from '@/baseElements/BaseSpinner/BaseSpinner.vue';

const props = defineProps({
  ariaLabel: {
    default: null,
    type: String
  },
  color: {
    default: 'primary',
    type: String,
    validator: value => {
      return ['primary', 'mi-light', 'secondary', 'success', 'danger', 'warning', 'light', 'dark', 'gray',
        'purple', 'purple-blue', 'cyan-blue', 'purple-pink', 'green-blue', 'pink-orange', 'teal-lime', 'red-yellow'].includes(value);
    }
  },

  colorType: {
    default: null,
    type: String,
    validator: value => {
      return [null, 'gradient', 'outline', 'no-border'].includes(value);
    }
  },
  icon: {
    default: null,
    type: String
  },
  iconPosition: {
    default: 'right',
    type: String,
    validator: value => {
      return ['left', 'right', 'center'].includes(value);
    }
  },
  tooltip: {
    default: null,
    type: String
  },
  round: {
    default: false,
    type: Boolean
  },
  title: {
    default: null,
    type: String
  },
  label: {
    default: null,
    type: String
  },
  loading: {
    type: Boolean
  },
  disabled: {
    type: Boolean
  },
  preventDefault: {
    type: Boolean
  },
  noWrap: {
    type: Boolean
  },
  size: {
    default: 'base',
    type: String,
    validator: value => {
      return ['xs', 'sm', 'base', 'lg', 'xl'].includes(value);
    }
  },
  type: {
    default: null,
    type: String,
    validator: value => {
      return [null, 'button', 'submit', 'reset'].includes(value);
    }
  },
  width: {
    default: 'auto',
    type: String,
    validator: value => {
      return ['fixed', 'fixed-mobile', 'auto', 'full'].includes(value);
    }
  }
});

const slots = useSlots();
const useSlotAPI = computed(() => {
  return (!props.label && !props.icon) || slots.default !== undefined;
});
const computedType = computed(() => {
  if (props.type) {
    return props.type;
  }
  if (useSlotAPI.value) {
    // The old implementation requires 'submit' unless specified
    return 'submit';
  }
  return 'button';
});

const emit = defineEmits(['handle-click']);
const handleClick = (e) => {
  if (props.preventDefault) {
    e.preventDefault();
  }
  emit('handle-click');
};

</script>

<style lang="scss" scoped>
.button {
  @apply focus:ring-2 font-medium text-center focus:outline-none rounded-md;
  @apply transition-all duration-200 inline-flex items-center justify-center;

  &-color {
    &-primary {
      @apply text-white bg-blue-600 hover:bg-blue-700 focus:ring-blue-300;
      @apply dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-500;

      &.button-outline {
        @apply text-blue-600 bg-transparent border border-blue-600 hover:bg-blue-600 hover:text-white;
        @apply dark:border-blue-500 dark:text-blue-400 dark:hover:bg-blue-500 dark:hover:text-white;
      }

      &.button-no-border {
        @apply text-blue-600 bg-transparent border-none hover:bg-blue-600 hover:text-white;
        @apply dark:text-blue-400 dark:hover:bg-blue-500 dark:hover:text-white;
      }
    }

    &-mi-light {
      @apply text-slate-900 bg-white border border-slate-200 hover:bg-slate-50 hover:text-slate-700
        focus:ring-slate-100;
      @apply dark:bg-slate-800 dark:text-slate-300 dark:border-slate-600
        dark:hover:bg-slate-700 dark:hover:text-white dark:focus:ring-slate-600;
    }

    &-dark {
      @apply bg-slate-800 hover:bg-slate-900 focus:ring-slate-300 text-white;
      @apply dark:bg-slate-700 dark:hover:bg-slate-600 dark:focus:ring-slate-500;

      &.button-outline {
        @apply text-slate-800 bg-transparent border border-slate-800 hover:bg-slate-800 hover:text-white;
        @apply dark:border-slate-600 dark:text-slate-400 dark:hover:bg-slate-600 dark:hover:text-white;
      }

      &.button-no-border {
        @apply text-slate-800 bg-transparent border-none hover:bg-slate-800 hover:text-white;
        @apply dark:text-slate-400 dark:hover:bg-slate-600 dark:hover:text-white;
      }
    }

    &-secondary {
      @apply text-white bg-slate-500 hover:bg-slate-600 focus:ring-slate-300;
      @apply dark:bg-slate-600 dark:hover:bg-slate-500 dark:focus:ring-slate-400;

      &.button-outline {
        @apply text-slate-500 bg-transparent border border-slate-500 hover:bg-slate-500 hover:text-white;
        @apply dark:text-slate-400 dark:border-slate-500 dark:hover:bg-slate-500 dark:hover:text-white;
      }

      &.button-no-border {
        @apply text-slate-500 bg-transparent border-none hover:bg-slate-500 hover:text-white;
        @apply dark:text-slate-400 dark:hover:bg-slate-600 dark:hover:text-white;
      }
    }

    &-success {
      @apply bg-green-600 hover:bg-green-700 focus:ring-green-300;
      @apply dark:focus:ring-green-800;

      &.button-outline {
        @apply text-green-600 hover:text-white border-green-600 hover:bg-green-600;
        @apply dark:bg-transparent dark:border-green-500 dark:text-green-500 dark:hover:text-white dark:hover:bg-green-600;
      }

      &.button-no-border {
        @apply text-green-600 hover:text-white hover:bg-green-600;
        @apply dark:text-green-500 dark:hover:text-white dark:hover:bg-green-600;
      }
    }

    &-danger {
      @apply bg-red-600 hover:bg-red-700 focus:ring-red-300;
      @apply dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-500;

      &.button-outline {
        @apply text-red-600 hover:text-white border-red-600 hover:bg-red-600;
        @apply dark:bg-transparent dark:border-red-500 dark:text-red-500 dark:hover:text-white dark:hover:bg-red-600;
      }

      &.button-no-border {
        @apply text-red-600 hover:text-white hover:bg-red-600;
        @apply dark:text-red-500 dark:hover:text-white dark:hover:bg-red-600;
      }
    }

    &-warning {
      @apply bg-yellow-500 hover:bg-yellow-600 focus:ring-yellow-300;
      @apply dark:focus:ring-yellow-600;

      &.button-outline {
        @apply text-yellow-600 hover:text-white border-yellow-500 hover:bg-yellow-500;
        @apply dark:bg-transparent dark:border-yellow-500 dark:text-yellow-500 dark:hover:text-white
        dark:hover:bg-yellow-600;
      }

      &.button-no-border {
        @apply text-yellow-600 hover:text-white hover:bg-yellow-500;
        @apply dark:text-yellow-500 dark:hover:text-white dark:hover:bg-yellow-600;
      }
    }

    &-light {
      @apply text-slate-900 bg-white border border-slate-300 hover:bg-slate-50 focus:ring-slate-100;
      @apply dark:bg-slate-800 dark:text-white dark:border-slate-600 dark:hover:bg-slate-700
        dark:focus:ring-slate-600;
    }

    &-gray {
      @apply bg-slate-400 hover:bg-slate-500 focus:ring-slate-300;
      @apply dark:bg-slate-600 dark:hover:bg-slate-500 dark:focus:ring-slate-400;
    }

    &-purple {
      @apply bg-purple-700 hover:bg-purple-800 focus:ring-purple-300;
      @apply dark:bg-purple-600 dark:hover:bg-purple-700 dark:focus:ring-purple-900;

      &.button-outline {
        @apply text-purple-700 hover:text-white border-purple-700;
        @apply dark:bg-transparent dark:border-purple-400 dark:text-purple-400 dark:hover:text-white
        dark:hover:bg-purple-500;
      }

      &.button-no-border {
        @apply text-purple-700 hover:text-white hover:bg-purple-700;
        @apply dark:text-purple-400 dark:hover:text-white dark:hover:bg-purple-500;
      }
    }

    &-purple-blue {
      @apply from-purple-600 to-blue-500 focus:ring-blue-300;
      @apply dark:focus:ring-blue-800;
    }

    &-cyan-blue {
      @apply text-white from-cyan-500 to-blue-500 focus:ring-cyan-300;
      @apply dark:focus:ring-cyan-800;
    }

    &-purple-pink {
      @apply from-purple-500 to-pink-500 focus:ring-purple-200;
      @apply dark:focus:ring-purple-800;
    }

    &-green-blue {
      @apply from-green-400 to-blue-600 focus:ring-green-200;
      @apply dark:focus:ring-green-800;
    }

    &-pink-orange {
      @apply from-pink-500 to-orange-400 focus:ring-pink-200;
      @apply dark:focus:ring-pink-800
    }

    &-teal-lime {
      @apply text-gray-900 from-teal-200 to-lime-200 hover:from-teal-200 hover:to-lime-200 focus:ring-lime-200;
      @apply dark:focus:ring-teal-700;
    }

    &-red-yellow {
      @apply text-gray-900 from-red-200 via-red-300 to-yellow-200 focus:ring-red-100;
      @apply dark:focus:ring-red-400;
    }
  }

  &.size {
    &-xs, &-sm {
      @apply px-3 py-2;
    }
    &-xs {
      @apply text-xs;
    }
    &-sm, &-base {
      @apply text-sm;
    }
    &-base, &-lg {
      @apply px-5;
    }
    &-base {
      @apply py-2.5;
    }
    &-lg, &-xl {
      @apply text-base;
    }
    &-lg {
      @apply py-3;
    }
    &-xl {
      @apply px-6 py-3.5;
    }
  }

  &.round {
    @apply rounded-full;
  }

  &-gradient {
    @apply bg-gradient-to-br hover:bg-gradient-to-bl
  }

  &-outline {
    @apply bg-transparent border;
  }

  &-no-border {
    @apply bg-transparent border-none ring-0 focus:ring-0 focus:border-none;
  }

  &-icon {
    @apply flex items-center;

    &-right {
      @apply flex-row-reverse;
      .icon {
        @apply ms-2;
      }
    }

    &-left {
      .icon {
        @apply me-2;
      }
    }

    &-center {
      @apply justify-center;
    }

    &-loading {
      @apply flex flex-row-reverse;
      .icon {
        @apply ms-2;
      }
    }
  }

  &.icon-only {
    @apply p-0;

    &.size {
      &-xs {
        @apply w-[0.9rem] h-[0.9rem] text-[0.7rem];
      }
      &-sm {
        @apply w-[1.3rem] h-[1.3rem] text-[0.9rem];
      }
      &-base {
        @apply w-8 h-8 text-[1.3rem];
      }
      &-lg {
        @apply p-0 w-8 h-8 text-[1.5rem];
      }
      &-xl {
        @apply  p-0 w-10 h-10 text-[1.5rem];
        @apply md:w-12 md:h-12 md:text-[2rem]
      }
    }
  }

  &:disabled {
    @apply cursor-not-allowed opacity-60 hover:opacity-50;
  }
}
</style>
