import { ref } from 'vue';

const activeLabels = ref({});
const useLoaderStatus = () => {
  function start(label) {
    activeLabels.value = { ...activeLabels.value, ...{ [label]: true } };
  }

  function end(label) {
    activeLabels.value = { ...activeLabels.value, ...{ [label]: false } };
  }

  return { start, end, is: activeLabels };
};

export { useLoaderStatus };
