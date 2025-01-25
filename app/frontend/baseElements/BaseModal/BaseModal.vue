<template>
  <div class="modal">
    <div
      class="modal-content"
      :class="{'modal-large':large}"
    >
      <BaseButton
        id="x-button"
        ref="closeButton"
        @handle-click="closeModal"
      >
        <span>&times;</span>
      </BaseButton>
      <div
        v-if="$slots.title"
        ref="title"
        class="modal-header"
        :class="{'text-center':centered}"
      >
        <BaseTitle
          id="modal-text"
          level="h5"
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
        class="modal-footer text-center"
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
      md:inset-0 h-full bg-slate-400;

    &-content {
      @apply relative bg-white rounded-lg dark:bg-gray-700;
    }

    &-large {
      @apply max-w-[80vw];
      @apply xl:max-w-[1024px];
    }

    &-body-fixed-scrollable {
      @apply overflow-y-auto h-[63vh];
    }

    &-body-with-border {
      padding: 1px;
      border: 8px solid gainsboro;
    }

    &-header {
      @apply flex items-center justify-between p-4 md:p-5 border-b rounded-t dark:border-gray-600;
    }
  }
  .modal-content,#x-button {
    @apply z-30;
  }
  #x-button {
    @apply absolute top-3 right-3;
  }
</style>
