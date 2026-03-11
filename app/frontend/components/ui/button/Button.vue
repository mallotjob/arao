<script setup>
import { buttonVariants } from '.';
import { cn } from '@/lib/utils';
import { Primitive } from 'reka-ui';

const props = defineProps({
  variant: { type: null, required: false, default: null },
  size: { type: null, required: false, default: null },
  class: { type: null, required: false, default: null },
  asChild: { type: Boolean, required: false, default: false },
  as: { type: null, required: false, default: 'button' },
});
</script>

<template>
  <Primitive
    :as="as"
    :as-child="asChild"
    :class="cn(buttonVariants({ variant, size }), props.class)"
  >
    <slot />
  </Primitive>
</template>
