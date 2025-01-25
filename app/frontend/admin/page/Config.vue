<template>
  <div>
    <button
      class="border-solid rounded text-white border-gray-500 p-2 bg-blue-400"
      @click="show=true"
    >
      create config
    </button>
    dfdsfs
    <BaseModal
      v-if="show"
      ref="modal"
      :large="true"
      @on-close="show=false"
    >
      <template #title>
        <div class="container-fluid">
          Certificate of coverage overview
        </div>
      </template>
      With less than a month to go before the European Union enacts
      new consumer privacy laws for its citizens, companies around the world are updating their terms of service
      agreements to comply. The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on May 25
      and is meant to ensure a common set of data rights in the European Union. It requires organizations to notify users
      as soon as possible of high-risk data breaches that could personally affect them.
    </BaseModal>
  </div>
</template>
<script setup>
import { ref } from 'vue';
import BaseModal from '@/baseElements/BaseModal/BaseModal.vue';

const show = ref(false);
</script>
<style lang="">

</style>
