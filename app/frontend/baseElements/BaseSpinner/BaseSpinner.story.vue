<template>
  <Story
    title="BaseElements / BaseSpinner"
    :layout="{type: 'grid', width: '100%'}"
  >
    <Variant title="Default state">
      <div class="test">
        <BaseSpinner font="slim" />
        <BaseSpinner color="danger" />
        <BaseSpinner font="fat" />
        <BaseSpinner
          font="fatter"
          color="success"
        />
      </div>
    </Variant>

    <Variant title="Edge Y">
      <div class="test">
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
      </div>
    </Variant>

    <Variant title="Size variation">
      <div class="test">
        <BaseSpinner size="xs" />
        <BaseSpinner size="sm" />
        <BaseSpinner />
        <BaseSpinner size="lg" />
        <BaseSpinner size="xl" />
        <BaseSpinner size="xxl" />
      </div>
    </Variant>
  </Story>
</template>

<script setup>
import BaseSpinner from './BaseSpinner.vue';

</script>
<style lang="scss" scoped>
.test {
  @apply flex;
;
}

</style>
