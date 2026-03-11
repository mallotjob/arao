import { FlatCompat } from '@eslint/eslintrc';
import globals from 'globals';
import js from '@eslint/js';
import pluginJs from '@eslint/js';
import pluginVue from 'eslint-plugin-vue';
import sortImportsEs6Autofix from 'eslint-plugin-sort-imports-es6-autofix';
import vitest from '@vitest/eslint-plugin';

const compat = new FlatCompat({
  recommendedConfig: js.configs.recommended,
  allConfig: js.configs.all
});

export default [
  ...compat.extends('eslint:recommended', 'plugin:vue/vue3-recommended'),
  pluginJs.configs.recommended,
  vitest.configs.recommended,
  ...pluginVue.configs['flat/essential'],
  {
    files: ['**/*.{js,mjs,cjs,vue}'],
    plugins: {
      'sort-imports-es6-autofix': sortImportsEs6Autofix,
      vitest
    },

    languageOptions: {
      globals: {
        ...globals.browser,
        describe: 'readonly',
        it: 'readonly',
        expect: 'readonly',
      }
    },
    rules: {
      'no-undef': 'off',
      camelcase: 0,
      indent: ['error', 2],
      'linebreak-style': ['error', 'unix'],
      'max-len': ['error', {
        code: 125,
        ignoreComments: true,
        ignoreStrings: true,
        ignoreTemplateLiterals: true,
        ignoreUrls: true
      }],
      'no-console': ['error', {
        allow: ['error', 'debug']
      }],
      'no-new': 0,
      'object-curly-spacing': ['error', 'always'],
      'quotes': [1, 'single', {
        'avoidEscape': true
      }],
      semi: ['error', 'always'],
      'sort-imports-es6-autofix/sort-imports-es6': ['warn', {
        ignoreCase: true
      }],
      'space-before-function-paren': ['error', {
        anonymous: 'never',
        asyncArrow: 'always',
        named: 'never'
      }],
      'vue/multi-word-component-names': 0,
      'vue/no-mutating-props': 1,
      'vue/no-reserved-component-names': 'off',
      'vue/no-template-key': 1,
      'vue/no-v-for-template-key': 0,
      'vue/no-v-html': 'off',
      'vue/singleline-html-element-content-newline': ['error', {
        ignoreWhenEmpty: true,
        ignoreWhenNoAttributes: true
      }]
    }
  }
];
