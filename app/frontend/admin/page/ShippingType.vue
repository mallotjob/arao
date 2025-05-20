<template>
  <div class="bg-red-400 text-yellow-700">
    List of shipped type
    <BaseButton
      label="create type"
      class="float-right"
    />

    <DataTable
      :value="products"
      table-style="min-width: 50rem"
    >
      <Column
        field="type"
        :header="t('type')"
      />
      <Column
        field=""
        :header="t('category')"
      >
        <template #body="slotProps">
          <div
            v-for="(config, index) in slotProps.data.configs"
            :key="index"
          >
            {{ config.category }}
          </div>
        </template>
      </Column>
      <Column
        field="null"
        :header="t('price')"
      >
        <template #body="slotProps">
          <div
            v-for="(config, index) in slotProps.data.configs"
            :key="index"
          >
            {{ config.price }}
          </div>
        </template>
      </Column>
      <Column
        field="null"
        :header="t('unit')"
      >
        <template #body="slotProps">
          <div
            v-for="(config, index) in slotProps.data.configs"
            :key="index"
          >
            {{ config.unit.name }} /
            {{ config.unit.unit }}
          </div>
        </template>
      </Column>
      <template
        v-if="products.length < 1"
        #footer
      >
        {{ $t('emptyResults') }}
      </template>
    </DataTable>
  </div>
</template>
<script setup>
import { ref } from 'vue';
import { useI18n } from 'vue-i18n';
import BaseButton from '@/baseElements/BaseButton/BaseButton.vue';

const { t } = useI18n();
const products = ref([
  {
    type: 'bateau',
    configs: [
      {
        category: 'simple',
        price: '123',
        currency: '$',
        unit: {
          name: 'poid',
          unit: 'kg'
        }
      },
      {
        category: 'lourd +500kg',
        price: '400',
        currency: '$',
        unit: {
          name: 'poid',
          unit: 'kg'
        }
      }
    ]
  },
  {
    type: 'bateau express',
    configs: [
      {
        category: 'simple',
        price: '200',
        currency: '$',
        unit: {
          name: 'poid',
          unit: 'kg'
        }
      },
      {
        category: 'lourd +500kg',
        price: '500',
        currency: '$',
        unit: {
          name: 'poid',
          unit: 'kg'
        }
      }
    ]
  }
]);
</script>
<style lang="">

</style>

<i18n lang="yaml">
en:
  category: Category
  type: Shipping type
  price: Price
  unit: Unit
fr:
  category: Catégorie
  type: Mode d'envoye
  price: Prix
  unit: Unité
mg:
  category: karazany
  type: Fomba fandefasana
  price: Vidiny
  unit: tare-marika
</i18n>
