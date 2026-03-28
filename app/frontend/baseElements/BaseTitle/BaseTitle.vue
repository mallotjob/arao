<template>
  <component
    :is="tag"
    class="custom-title"
    :class="{
      'text-3xl': level === 'h1',
      'text-2xl': level === 'h2',
      'text-xl': level === 'h3',
      'text-lg': level === 'h4',
      'text-base': level === 'h5',
      'text-sm': level === 'h6'
    }"
  >
    <slot />
  </component>
</template>

<script setup>
const props = defineProps({
  level: {
    type: String,
    required: true,
    validator: value => {
      const validLevels = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'];
      return validLevels.includes(value);
    }
  }
});

const tag = props.level;
</script>

<style lang="scss" scoped>
.custom-title {
  @apply font-semibold text-slate-900 dark:text-white leading-tight;
}
</style>
