<template>
  <div
    class="spinner"
    :class="{
      ['size-' + size]: size,
      ['color-' + color]: color,
      ['font-' + font]: font,
      ['type-' + type]: type,
    }"
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

  @apply rounded-full animate-spin
  border border-solid shadow-md;

  &.size {
    &-xs {
      @apply w-5 h-5;
    }

    &-sm {
      @apply w-6 h-6;
    }

    &-base {
      @apply w-8 h-8;
    }

    &-lg {
      @apply w-12 h-12;
    }

    &-xl {
      @apply w-20 h-20;
    }

    &-xxl {
      @apply w-28 h-28;
    }
  }

  &.color {
    &-slate {
      @apply border-slate-600 border-t-transparent;
      @apply dark:border-slate-400 dark:border-t-transparent;
    }

    &-primary {
      @apply border-slate-600 border-t-transparent;
      @apply dark:border-slate-400 dark:border-t-transparent;
    }

    &-dark {
      @apply border-slate-800 border-t-transparent;
      @apply dark:border-slate-300 dark:border-t-transparent;
    }

    &-success {
      @apply border-green-600 border-t-transparent;
      @apply dark:border-green-500 dark:border-t-transparent;
    }

    &-danger {
      @apply border-red-600 border-t-transparent;
      @apply dark:border-red-500 dark:border-t-transparent;
    }

    &-light {
      @apply border-white border-t-transparent;
      @apply dark:border-slate-200 dark:border-t-transparent;
    }

    &-warning {
      @apply border-yellow-500 border-t-transparent;
      @apply dark:border-yellow-400 dark:border-t-transparent;
    }
  }

  &.font {
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
      @apply border-0 border-y;

      &.font {
        &-base {
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
