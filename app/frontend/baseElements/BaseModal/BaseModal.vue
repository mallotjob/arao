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
          :class="{'w-100':centered}"
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
    @apply overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-20 flex justify-center items-center w-full
      md:inset-0 h-full;

    &-title {
      @apply p-0 !m-0;
    }

    &-header {
      @apply p-6 pr-16 md:pr-16 border-b border-gray-300;
      @apply dark:border-gray-600;
    }

    &-content {
      @apply absolute bg-white rounded-lg text-gray-700 w-11/12 max-w-md;
      @apply dark:bg-gray-700 dark:text-white;

      &,#x-button {
        @apply z-30;
      }
    }

    &-body {
      @apply p-4;
    }

    &-footer {
      @apply p-4 pr-16 md:pr-16 border-t border-gray-300 flex justify-end;
      @apply dark:border-gray-600;
    }

    &-large {
      @apply max-w-[80vw];
      @apply xl:max-w-[1024px];
    }

    &-body-fixed-scrollable {
      @apply overflow-y-auto h-[63vh];
    }

    &-body-with-border {
      @apply p-4 border-8 border-solid border-gray-100;
    }

    &-backdrop {
      @apply bg-black/30 w-full h-full;
    }

    #x-button {
      @apply absolute top-2 right-2;
    }
  }
</style>
