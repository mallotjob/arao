<template>
  <div
    class="spinner"
    :class="{
      ['size-' + size]: size,
      ['color-' + color]: color,
      ['font-' + font]: font,
      ['type-' + type]: type,
    }"
    role="status"
    aria-label="Loading"
  />
</template>

<script setup>
defineProps({
  color: {
    default: 'slate',
    type: String,
    validator: value => {
      return ['slate', 'primary', 'success', 'danger', 'warning', 'light', 'dark'].includes(value);
    }
  },
  size: {
    default: 'base',
    type: String,
    validator: value => {
      return ['xs', 'sm', 'base', 'lg', 'xl'].includes(value);
    }
  },
  font: {
    default: 'base',
    type: String,
    validator: value => {
      return ['slim', 'base', 'fat', 'fatter'].includes(value);
    }
  },
  type: {
    default: 'base',
    type: String,
    validator: value => {
      return ['base', 'ringY'].includes(value);
    }
  },
});
</script>

<style lang="scss" scoped>
.spinner {
  @apply rounded-full animate-spin border border-solid;
  @apply shadow-sm;

  &.size {
    &-xs {
      @apply w-4 h-4;
    }

    &-sm {
      @apply w-5 h-5;
    }

    &-base {
      @apply w-6 h-6;
    }

    &-lg {
      @apply w-8 h-8;
    }

    &-xl {
      @apply w-12 h-12;
    }
  }

  &.color {
    &-slate {
      @apply border-slate-200 border-t-slate-600;
      @apply dark:border-slate-700 dark:border-t-slate-400;
    }

    &-primary {
      @apply border-blue-200 border-t-blue-600;
      @apply dark:border-blue-700 dark:border-t-blue-500;
    }

    &-dark {
      @apply border-slate-300 border-t-slate-800;
      @apply dark:border-slate-600 dark:border-t-slate-300;
    }

    &-success {
      @apply border-green-200 border-t-green-600;
      @apply dark:border-green-700 dark:border-t-green-500;
    }

    &-danger {
      @apply border-red-200 border-t-red-600;
      @apply dark:border-red-700 dark:border-t-red-500;
    }

    &-light {
      @apply border-white border-t-slate-400;
      @apply dark:border-slate-700 dark:border-t-slate-300;
    }

    &-warning {
      @apply border-yellow-200 border-t-yellow-500;
      @apply dark:border-yellow-700 dark:border-t-yellow-400;
    }
  }

  &.font {
    &-slim {
      @apply border-2;
    }

    &-base {
      @apply border-2;
    }

    &-fat {
      @apply border-4;
    }

    &-fatter {
      @apply border-8;
    }
  }

  &.type {
    &-ringY {
      @apply border-0 border-y-2;

      &.font {
        &-slim, &-base {
          @apply border-y-2;
        }

        &-fat {
          @apply border-y-4;
        }

        &-fatter {
          @apply border-y-8;
        }
      }
    }
  }
}
</style>
