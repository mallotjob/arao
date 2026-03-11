<template>
  <component
    :is="tag"
    class="custom-title"
  >
    <slot />
  </component>
</template>

<script>
export default {
  props: {
    level: {
      type: String,
      required: true
    }
  },
  computed: {
    tag() {
      const validLevels = ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'];
      const level = validLevels.includes(this.level) ? this.level : 'h1';
      return level;
    }
  }
};
</script>
