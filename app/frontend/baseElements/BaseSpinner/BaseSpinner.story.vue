<template>
  <Story
    title="BaseElements / BaseSpinner"
    :layout="{type: 'grid', width: '100%'}"
  >
    <Variant title="Default state">
      <BaseSpinner font="slim" />
      <BaseSpinner color="danger" />
      <BaseSpinner font="fat" />
      <BaseSpinner
        font="fatter"
        color="success"
      />
    </Variant>

    <Variant title="Size small">
      <BaseSpinner
        font="slim"
        type="ringY"
        color="light"
      />
      <BaseSpinner type="ringY" />
      <BaseSpinner
        font="fat"
        type="ringY"
        color="dark"
      />
      <BaseSpinner
        font="fatter"
        type="ringY"
        color="warning"
      />
    </Variant>
  </Story>
</template>

<script setup>
import BaseSpinner from './BaseSpinner.vue';

</script>
<style lang="scss" scoped>


</style>
