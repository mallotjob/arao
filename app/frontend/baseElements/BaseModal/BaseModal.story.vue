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
          tetur adipisicing elit. Ipsam, dolorum qui
        </template>
        <div class="w-100 p-3">
          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="schemeConfig">
                  schemeConfig
                </label>
                <input
                  id="schemeConfig"
                  ref="schemeConfigInput"
                  type="text"
                  class="form-control"
                >
              </div>

              <div class="form-group">
                <label for="startDate">
                  certificateStartDate
                </label>
                <input
                  id="startDate"
                  v-model="certificateStartDate"
                  type="date"
                  class="form-control"
                >
              </div>
              <div class="form-group">
                <label for="endDate">
                  certificateEndDate
                </label>
                <input
                  id="endDate"
                  v-model="certificateEndDate"
                  type="date"
                  class="form-control"
                >
              </div>
            </div>
          </div>
        </div>

        <template #footer>
          <BaseButton
            id="submitCertificate"
            class="btn btn-primary"
            @handle-click="show=false"
          >
            createCertificate
          </BaseButton>
        </template>
      </BaseModal>

      <BaseButton
        class="btn btn-dark"
        @handle-click="show=true"
      >
        Open modal large with header
      </BaseButton>
    </Variant>
    <br>
    <Variant title="nolarge">
      <BaseModal
        v-if="show2"
        @on-close="show2=false"
      >
        <div>
          <div class="text-center">
            <div class="display-4 text-danger">
              <i
                class="fa fa-exclamation-circle"
                aria-hidden="true"
              />
            </div>
            <div class="my-2">
              <h4> modalTitle </h4>
              <p class="mx-2 my-2">
                <small>The beneficiary will be deleted from your local storage and you won’t be able to restore it.</small>
              </p>
            </div>
          </div>
          <div class="d-flex justify-content-center w-100 px-5">
            <div>
              <BaseButton
                id="discard-delete"
                class="btn btn-outline-secondary btn-mm mx-3"
                data-dismiss="modal"
                @handle-click="show2=false"
              >
                cancelText
              </BaseButton>
            </div>

            <div>
              <BaseButton
                id="confirm-delete"
                class="btn btn-outline-danger btn-mm mx-3"
                data-dismiss="modal"
                @handle-click="show2=false"
              >
                submitText
              </BaseButton>
            </div>
          </div>
        </div>
      </BaseModal>

      <BaseButton
        class="btn btn-dark my-2"
        @handle-click="show2=true"
      >
        Open modal small with header
      </BaseButton>
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
