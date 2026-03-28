<template>
  <div class="modal">
    <div
      class="modal-content"
      :class="{'modal-large':large}"
    >
      <BaseButton
        id="x-button"
        ref="closeButton"
        color="secondary"
        color-type="no-border"
        icon-position="center"
        :icon="['fas', 'fa-xmark']"
        class="absolute top-3 right-3"
        @handle-click="closeModal"
      />
      <div
        v-if="$slots.title"
        ref="title"
        class="modal-header"
        :class="{'text-center':centered}"
      >
        <BaseTitle
          id="modal-text"
          level="h3"
          class="modal-title"
          :class="{'w-full':centered}"
        >
          <slot name="title" />
        </BaseTitle>
      </div>

      <div
        ref="body"
        class="modal-body"
        :class="{'modal-body-fixed-scrollable': large,'modal-body-with-border': withBorder }"
      >
        <slot />
      </div>
      <div
        v-if="$slots.footer"
        class="modal-footer"
      >
        <slot
          name="footer"
        />
      </div>
    </div>
    <div
      ref="modalBackdrop"
      class="modal-backdrop show"
      @click="closeModal"
    />
  </div>
</template>

<script setup>
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';
import BaseTitle from '@/baseElements/BaseTitle/BaseTitle.vue';

const emit = defineEmits(['onClose']);
defineProps({
  large: {
    default: false,
    required: false,
    type: Boolean
  },
  withBorder: {
    default: false,
    type: Boolean
  },
  centered: {
    default: false,
    required: false,
    type: Boolean
  }
});

const closeModal = () => {
  emit('onClose');
};
</script>

<style lang='scss' scoped>
.modal {
  @apply overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50;
  @apply flex justify-center items-center w-full md:inset-0 h-full;

  &-title {
    @apply p-0 !m-0;
  }

  &-header {
    @apply px-6 py-4 border-b border-slate-200 dark:border-slate-600;
    @apply rounded-t-lg;
  }

  &-content {
    @apply relative bg-white dark:bg-slate-800 rounded-lg;
    @apply text-slate-700 dark:text-slate-300 w-11/12 max-w-md shadow-lg;
    @apply dark:border dark:border-slate-600;

    &,#x-button {
      @apply z-50;
    }
  }

  &-body {
    @apply p-6;
  }

  &-footer {
    @apply p-4 px-6 border-t border-slate-200 dark:border-slate-600;
    @apply flex justify-end items-center space-x-3 rounded-b-lg;
  }

  &-large {
    @apply max-w-[80vw] xl:max-w-[1024px];
  }

  &-body-fixed-scrollable {
    @apply overflow-y-auto h-[63vh];
  }

  &-body-with-border {
    @apply p-4 border-8 border-solid border-slate-100 dark:border-slate-700;
  }

  &-backdrop {
    @apply bg-black/50 w-full h-full fixed inset-0;
  }
}
</style>
