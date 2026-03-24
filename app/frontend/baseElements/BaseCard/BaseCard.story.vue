<template>
  <Story
    title="BaseElements / BaseCard"
    :layout="{type: 'grid', width: '100%'}"
  >
    <Variant title="Default state">
      <BaseCard title="Title for BaseCard">
        default slot
      </BaseCard>
    </Variant>

    <Variant title="Default state, title with background white">
      <BaseCard
        title="Title for BaseCard"
        :bg-white="true"
      >
        default slot
      </BaseCard>
    </Variant>

    <Variant title="With actions slot">
      <BaseCard title="Title for BaseCard">
        <template #actions>
          actions slot
        </template>
        default slot
      </BaseCard>
    </Variant>

    <Variant title="Without card-body">
      <BaseCard
        title="Title for BaseCard"
        :card-body="false"
      >
        <div class="p-5">
          Removed default `card-body` class so we can use `p-5` for example
        </div>
      </BaseCard>
    </Variant>

    <Variant title="With footer action">
      <BaseCard title="Title for BaseCard">
        Removed default `card-body` class so we can use `p-5` for example

        <template #footerActions>
          <BaseButton> create certificate </BaseButton>
        </template>
      </BaseCard>
    </Variant>

    <Variant title="Without title and slot header">
      <BaseCard>
        Removed default `card-body` class so we can use `p-5` for example
      </BaseCard>
    </Variant>

    <Variant title="With slot header">
      <BaseCard>
        <template #header>
          test slot header
        </template>
        Removed default `card-body` class so we can use `p-5` for example
      </BaseCard>
    </Variant>

    <Variant title="With slot footer">
      <BaseCard>
        Removed default `card-body` class so we can use `p-5` for example
        <template #footer>
          test footer card
        </template>
      </BaseCard>
    </Variant>

    <Variant title="With all together">
      <BaseCard>
        <template #header>
          test header card
        </template>
        Removed default `card-body` class so we can use `p-5` for example
        <template #footerActions>
          <BaseButton> create certificate </BaseButton>
        </template>
        <template #footer>
          <BaseButton
            class="!tw-mr-2"
            label="create certificate"
          />
          <BaseButton
            color="danger"
            label="delete certificate"
          />
        </template>
      </BaseCard>
    </Variant>
  </Story>
</template>

<script setup>
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';
import BaseCard from '@/baseElements/BaseCard/BaseCard.vue';
</script>
