<template>
  <Story
    title="BaseElements / BaseButton"
    :layout="{type: 'grid', width: '100%'}"
  >
    <Variant title="default">
      <BaseButton label="primary" />
      <BaseButton color="mi-light">
        Alternative
      </BaseButton>
      <BaseButton color="dark">
        Dark
      </BaseButton>
      <BaseButton color="secondary">
        Secondary
      </BaseButton>
      <BaseButton color="success">
        Success
      </BaseButton>
      <BaseButton color="danger">
        Danger
      </BaseButton>
      <BaseButton color="warning">
        Warning
      </BaseButton>
      <BaseButton color="light">
        Light
      </BaseButton>
      <BaseButton color="gray">
        Gray
      </BaseButton>
      <BaseButton color="purple">
        Purple
      </BaseButton>
    </Variant>

    <Variant title="gradient">
      <BaseButton
        color="purple-blue"
        color-type="gradient"
      >
        Purple blue
      </BaseButton>

      <BaseButton
        color="cyan-blue"
        color-type="gradient"
      >
        Cyan blue
      </BaseButton>

      <BaseButton
        color="purple-pink"
        color-type="gradient"
      >
        purple pink
      </BaseButton>

      <BaseButton
        color="green-blue"
        color-type="gradient"
      >
        green blue
      </BaseButton>

      <BaseButton
        color="pink-orange"
        color-type="gradient"
      >
        pink orange
      </BaseButton>

      <BaseButton
        color="teal-lime"
        color-type="gradient"
      >
        teal lime
      </BaseButton>

      <BaseButton
        color="red-yellow"
        color-type="gradient"
      >
        red yellow
      </BaseButton>
    </Variant>

    <Variant title="outline">
      <BaseButton
        color-type="outline"
      >
        Primary
      </BaseButton>

      <BaseButton
        color="dark"
        color-type="outline"
      >
        Dark
      </BaseButton>

      <BaseButton
        color="secondary"
        color-type="outline"
      >
        secondary
      </BaseButton>

      <BaseButton
        color="success"
        color-type="outline"
      >
        success
      </BaseButton>

      <BaseButton
        color="danger"
        color-type="outline"
      >
        danger
      </BaseButton>

      <BaseButton
        color="warning"
        color-type="outline"
      >
        warning
      </BaseButton>

      <BaseButton
        color="purple"
        color-type="outline"
      >
        purple
      </BaseButton>
    </Variant>

    <Variant title="size">
      <BaseButton size="xs">
        Button xs
      </BaseButton>

      <BaseButton size="sm">
        Button sm
      </BaseButton>

      <BaseButton>
        Button base
      </BaseButton>

      <BaseButton size="lg">
        Button lg
      </BaseButton>

      <BaseButton size="xl">
        Button xl
      </BaseButton>
    </Variant>


    <Variant title="label with icon">
      <BaseButton>
        middle
        <font-awesome-icon :icon="['fas', 'house']" />
      </BaseButton>

      <BaseButton
        color="purple-blue"
        color-type="gradient"
        label="label"
        :icon="['fa', 'plus']"
      />

      <BaseButton
        color="purple-blue"
        color-type="gradient"
        label="label"
        icon-position="left"
        :icon="['fas', 'check']"
      />
    </Variant>

    <Variant title="icon">
      <BaseButton
        color="pink-orange"
        color-type="gradient"
        size="xs"
        icon-position="center"
        :icon="['fas', 'heart']"
      />
      <BaseButton
        color="dark"
        color-type="outline"
        size="sm"
        icon-position="center"
        :icon="['fas', 'heart']"
      />

      <BaseButton
        color="danger"
        color-type="outline"
        :round="true"
        size="sm"
        icon-position="center"
        :icon="['fas', 'xmark']"
      />

      <BaseButton
        color="danger"
        :round="true"
        icon-position="center"
        :icon="['fas', 'xmark']"
      />

      <BaseButton
        color="success"
        icon-position="center"
        :icon="['fas', 'xmark']"
      />

      <BaseButton
        icon-position="center"
        size="xs"
        :icon="['fas', 'arrow-right']"
      />

      <BaseButton
        icon-position="center"
        size="sm"
        :icon="['fas', 'arrow-right']"
      />

      <BaseButton
        icon-position="center"
        :icon="['fas', 'arrow-right']"
      />

      <BaseButton
        icon-position="center"
        size="lg"
        :icon="['fas', 'arrow-right']"
      />

      <BaseButton
        icon-position="center"
        size="xl"
        :icon="['fas', 'arrow-right']"
      />

      <BaseButton
        :round="true"
        color-type="gradient"
        color="pink-orange"
        icon-position="center"
        size="xs"
        :icon="['fas', 'arrow-right']"
      />

      <BaseButton
        :round="true"
        color-type="gradient"
        color="pink-orange"
        icon-position="center"
        size="sm"
        :icon="['fas', 'arrow-right']"
      />

      <BaseButton
        :round="true"
        color-type="gradient"
        color="pink-orange"
        icon-position="center"
        :icon="['fas', 'arrow-right']"
      />

      <BaseButton
        :round="true"
        color-type="gradient"
        color="pink-orange"
        icon-position="center"
        size="lg"
        :icon="['fas', 'arrow-right']"
      />

      <BaseButton
        :round="true"
        color-type="gradient"
        color="pink-orange"
        icon-position="center"
        size="xl"
        :icon="['fas', 'arrow-right']"
      />
    </Variant>

    <Variant title="disabled">
      <BaseButton
        color="purple-blue"
        color-type="gradient"
        :disabled="true"
        label="label"
        :icon="['fa', 'plus']"
      />

      <BaseButton
        color="cyan-blue"
        color-type="gradient"
        label="label"
        :disabled="true"
        icon-position="left"
        :icon="['fas', 'check']"
      />

      <BaseButton
        color="cyan-blue"
        loading="true"
        color-type="gradient"
        label="label"
        icon-position="left"
        :icon="['fas', 'check']"
      />

      <BaseButton
        color="danger"
        loading="true"
        label="label"
      />
    </Variant>
  </Story>
</template>

<script setup>
import BaseButton from './BaseButton.vue';

</script>
