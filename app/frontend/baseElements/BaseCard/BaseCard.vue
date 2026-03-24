<template>
  <div
    class="base-card-box"
    :class="{'card-inside': cardInside}"
  >
    <BaseTitle
      v-if="hasHeaderSlot || title"
      ref="header"
      class="base-card-header flex justify-between"
      :class="{'!bg-white': bgWhite, '!text-black': bgWhite }"
      :level="hasHeaderSlot ? 'h4': headerTag"
    >
      <span
        v-if="title"
        class="my-auto text-lg font-medium text-slate-900 dark:text-white"
      >
        {{ title }}
      </span>
      <small
        v-if="hasHeaderSlot"
        class="font-light"
      >
        <slot name="header" />
      </small>
      <slot name="actions" />
    </BaseTitle>
    <div
      v-if="hasDefaultSlot"
      :class="cardBody ? 'base-card-body' : null"
    >
      <slot />
    </div>
    <div
      v-if="hasFooterActionsSlot"
      class="base-card-action"
    >
      <slot name="footerActions" />
    </div>
    <div
      v-if="hasFooterSlot"
      class="base-card-footer"
    >
      <slot name="footer" />
    </div>
  </div>
</template>

<script setup>
import { computed, useSlots } from 'vue';
import BaseTitle from '@/baseElements/BaseTitle/BaseTitle.vue';

const slots = useSlots();
const hasDefaultSlot = computed(() => slots.default);
const hasFooterActionsSlot = computed(() => slots.footerActions);
const hasFooterSlot = computed(() => slots.footer);
const hasHeaderSlot = computed(() => slots.header);

const props = defineProps({
  bgWhite: {
    default: false,
    type: Boolean
  },
  cardBody: {
    default: true,
    type: Boolean
  },
  cardInside: {
    default: false,
    type: Boolean
  },
  headerLevel: {
    default: 5,
    type: [String, Number],
    validator: value => {
      const validLevels = ['1', '2', '3', '4', '5', '6', 1, 2, 3, 4, 5, 6];
      return validLevels.includes(value);
    }
  },
  title: {
    default: null,
    type: String
  }
});

const headerTag = computed(() => `h${props.headerLevel}`);
</script>

<style lang='scss' scoped>
.base-card {
  &-box {
    @apply bg-white dark:bg-slate-800 rounded-lg shadow border border-slate-200 dark:border-slate-700
      flex flex-col justify-between;
    &.card-inside {
      @apply bg-slate-50 dark:bg-slate-700 p-4;
    }
  }
  &-header, &-footer {
    @apply px-6 py-4 border-b border-slate-200;
  }
  &-action {
    @apply mt-4 p-4;
  }
  &-footer {
    @apply border-b-0 border-t rounded-b-lg text-lg font-medium text-slate-900 dark:text-white;
  }
  &-header {
    @apply rounded-t-md;
  }
  &-body {
    @apply flex-1;
  }
}
</style>
