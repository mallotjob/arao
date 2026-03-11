<template>
  <Story
    title="BaseElements / BaseModal"
    :layout="{type: 'grid', width: '100%'}"
  >
    <Variant title="large">
      <BaseModal
        v-if="show"
        :large="true"
        @on-close="show=false"
      >
        <template #title>
          Lorem ipsum dolor sit amet consec
        </template>
        <div>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            With less than a month to go before the European Union enacts new consumer privacy laws for its citizens,
            companies around the world are updating their terms of service agreements to comply.
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on May 25 and is meant
            to ensure a common set of data rights in the European Union. It requires organizations to notify users as
            soon as possible of high-risk data breaches that could personally affect them.
          </p>

          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            With less than a month to go before the European Union enacts new consumer privacy laws for its citizens,
            companies around the world are updating their terms of service agreements to comply.
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on May 25 and is meant
            to ensure a common set of data rights in the European Union. It requires organizations to notify users as
            soon as possible of high-risk data breaches that could personally affect them.
          </p>

          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            With less than a month to go before the European Union enacts new consumer privacy laws for its citizens,
            companies around the world are updating their terms of service agreements to comply.
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on
            May 25 and is meant to ensure a common set of data rights in the European Union.
            It requires organizations to notify users as soon as possible of high-risk data breaches that
            could personally affect them.
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on
            May 25 and is meant to ensure a common set of data rights in the European Union.
            It requires organizations to notify users as soon as possible of high-risk data breaches that
            could personally affect them.
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on
            May 25 and is meant to ensure a common set of data rights in the European Union.
            It requires organizations to notify users as soon as possible of high-risk data breaches that
            could personally affect them.
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on
            May 25 and is meant to ensure a common set of data rights in the European Union.
            It requires organizations to notify users as soon as possible of high-risk data breaches that
            could personally affect them.
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on
            May 25 and is meant to ensure a common set of data rights in the European Union.
            It requires organizations to notify users as soon as possible of high-risk data breaches that
            could personally affect them.
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on
            May 25 and is meant to ensure a common set of data rights in the European Union.
            It requires organizations to notify users as soon as possible of high-risk data breaches that
            could personally affect them.
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on
            May 25 and is meant to ensure a common set of data rights in the European Union.
            It requires organizations to notify users as soon as possible of high-risk data breaches that
            could personally affect them.
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on
            May 25 and is meant to ensure a common set of data rights in the European Union.
            It requires organizations to notify users as soon as possible of high-risk data breaches that
            could personally affect them.
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on
            May 25 and is meant to ensure a common set of data rights in the European Union.
            It requires organizations to notify users as soon as possible of high-risk data breaches that
            could personally affect them.
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            The European Union’s General Data Protection Regulation (G.D.P.R.) goes into effect on
            May 25 and is meant to ensure a common set of data rights in the European Union.
            It requires organizations to notify users as soon as possible of high-risk data breaches that
            could personally affect them.
          </p>
        </div>

        <template #footer>
          <BaseButton
            id="submitCertificate"
            label="createCertificate"
            @handle-click="show=false"
          />
        </template>
      </BaseModal>

      <BaseButton
        color="dark"
        label="Open modal large with header"
        @handle-click="show=true"
      />
    </Variant>
    <br>
    <Variant title="nolarge">
      <BaseModal
        v-if="show2"
        @on-close="show2=false"
      >
        <div class="class-class">
          <font-awesome-icon
            :icon="['fas', 'circle-exclamation']"
            class="icon"
          />
          <h3 class="text">
            Are you sure you want to delete this product?
          </h3>
          <div>
            <BaseButton
              color="danger"
              label="Yes, I'm sure"
              type="button"
              @handle-click="show2=false"
            />
            <BaseButton
              color="secondary"
              label="No, cancel"
              @handle-click="show2=false"
            />
          </div>
        </div>
      </BaseModal>

      <BaseButton
        color="purple"
        label="Open modal small with header"
        @handle-click="show2=true"
      />
    </Variant>
  </Story>
</template>

<script setup>
import { ref } from 'vue';
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';
import BaseModal from './BaseModal.vue';

const show = ref(false);
const show2 = ref(false);
</script>

<style lang="scss" scoped>
.class-class {
  @apply flex flex-col items-center justify-center p-0 sm:p-6;
  .text {
    @apply mb-5 text-lg font-normal text-gray-500 dark:text-gray-400 text-center;
  }

  .icon {
    @apply text-6xl;
  }
}
</style>
