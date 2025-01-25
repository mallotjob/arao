<template>
  <button
    v-tooltip.bottom="tooltip"
    class="button"
    :class="{
      ['button-color-' + color]: color,
      ['button-' + colorType]: colorType,
      ['size-' + size]: size,
      'round': round,
      'icon-only': !label && icon,
    }"
    :disabled="loading"
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
        <font-awesome-icon
          v-if="!loading"
          :icon="icon"
        />
        <span
          v-if="loading"
          class="loading"
        >
          <!-- <BaseSpinner
            v-if="loading"
            size="sm"
          /> -->
        </span>
      </span>
      {{ label }}
    </span>
  </button>
</template>

<script setup>
import { computed, useSlots } from 'vue';
// import BaseSpinner from '@/baseElements/BaseSpinner/BaseSpinner.vue';

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
      return [null, 'gradient', 'outline'].includes(value);
    }
  },
  icon: {
    default: null,
    type: Array
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
  @apply focus:ring-2 font-medium text-center me-2 mb-2 focus:outline-none rounded-lg;
  &-color {
    &-primary {
     @apply text-white bg-blue-700 hover:bg-blue-800 focus:ring-blue-300;
     @apply dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800;

     &.button-outline {
      @apply text-blue-700 hover:text-white border-blue-700;
      @apply dark:border-blue-500 dark:text-blue-500 dark:hover:text-white dark:hover:bg-blue-500;
     }
    }

    &-mi-light {
      @apply text-gray-900 bg-white border border-gray-200 hover:bg-gray-100 hover:text-blue-700
       focus:ring-gray-100;
      @apply dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600
      dark:hover:text-white dark:hover:bg-gray-700;
    }

    &-dark {
      @apply bg-gray-800 hover:bg-gray-900 focus:ring-gray-300;
      @apply dark:hover:bg-gray-700 dark:focus:ring-gray-700 dark:border-gray-700;

      &.button-outline {
        @apply  hover:text-white border-gray-800;
        @apply dark:border-gray-600 dark:text-gray-400 dark:hover:text-white;
      }
    }

    &-secondary {
      @apply bg-gray-500 hover:bg-gray-600 focus:ring-gray-300;
      @apply dark:hover:bg-gray-400 dark:focus:ring-gray-400 dark:border-gray-400;

      &.button-outline {
        @apply text-gray-400 hover:text-white border-gray-500;
        @apply dark:text-gray-400 dark:hover:text-white dark:focus:ring-gray-800;
      }
    }

    &-success {
      @apply bg-green-600 hover:bg-green-700 focus:ring-green-300;
      @apply dark:focus:ring-green-800;

      &.button-outline {
        @apply text-green-700 hover:text-white border-green-700;
        @apply dark:border-green-500 dark:text-green-500 dark:hover:text-white dark:hover:bg-green-600;
      }
    }

    &-danger {
      @apply bg-red-700 hover:bg-red-800 focus:ring-red-300;
      @apply dark:bg-red-600 dark:hover:bg-red-700 dark:focus:ring-red-900;

      &.button-outline {
        @apply text-red-700 hover:text-white border-red-700;
        @apply dark:border-red-500 dark:text-red-500 dark:hover:text-white;
      }
    }

    &-warning {
      @apply bg-yellow-400 hover:bg-yellow-500 focus:ring-yellow-300;
      @apply dark:focus:ring-yellow-900;

      &.button-outline {
        @apply text-yellow-400 hover:text-white border-yellow-400;
        @apply dark:border-yellow-300 dark:text-yellow-300 dark:hover:text-white dark:hover:bg-yellow-400;
      }
    }

    &-light {
      @apply text-gray-900 bg-white border border-gray-300 hover:bg-gray-100 focus:ring-gray-100;
      @apply dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700
      dark:hover:border-gray-600 dark:focus:ring-gray-700;
    }

    &-gray {
      @apply bg-gray-400 hover:bg-gray-500 focus:ring-gray-300;
      @apply dark:focus:ring-gray-400 dark:border-gray-400;
    }

    &-purple {
      @apply bg-purple-700 hover:bg-purple-800 focus:ring-purple-300;
      @apply dark:bg-purple-600 dark:hover:bg-purple-700 dark:focus:ring-purple-900;

      &,.button-outline {
        @apply text-purple-700 hover:text-white border-purple-700;
        @apply dark:border-purple-400 dark:text-purple-400 dark:hover:text-white dark:hover:bg-purple-500;
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
