<template>
  <Story
    title="BaseElements / BaseTitle"
    :layout="{type: 'grid', width: '100%'}"
  >
    <Variant title="Default state h1">
      <div class="m-2">
        <BaseTitle
          level="h1"
        >
          Heading
        </BaseTitle>
      </div>
    </Variant>

    <Variant title="Size: h2">
      <BaseTitle
        level="h2"
      >
        Heading: h2
      </BaseTitle>
    </Variant>

    <Variant title="Size: h3">
      <BaseTitle
        level="h3"
      >
        Heading: h3
      </BaseTitle>
    </Variant>

    <Variant title="Size: h4">
      <BaseTitle
        level="h4"
      >
        Heading: h4
      </BaseTitle>
    </Variant>

    <Variant title="Size: h5">
      <BaseTitle
        level="h5"
      >
        Heading: h5
      </BaseTitle>
    </Variant>
  </Story>
</template>

<script setup>
import BaseTitle from './BaseTitle.vue';

</script>
