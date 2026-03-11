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
    default: 'primary',
    type: String,
    validator: value => {
      return ['primary', 'success', 'danger', 'warning', 'light', 'dark'].includes(value);
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
    &-primary {
      @apply border-blue-700 border-t-transparent;
    }

    &-dark {
      @apply border-gray-800 border-t-transparent;
    }

    &-success {
      @apply border-green-600 border-t-transparent;
    }

    &-danger {
      @apply border-red-500 border-t-transparent;
    }

    &-light {
      @apply border-white hover:border-gray-100 border-t-transparent;
    }

    &-warning {
      @apply border-yellow-400 border-t-transparent;
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
