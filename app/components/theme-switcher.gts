import { on } from '@ember/modifier';
import service from 'polaris-toucan-starter/helpers/service';

<template>
  {{#let (service 'theme-manager') as |themeManager|}}
    <button
      type="button"
      class="
        inline-flex items-center px-2 py-1 rounder-sm type-md-medium
        focusable-outer focusable-primary interactive-normal"
      {{on 'click' themeManager.toggleTheme}}
    >
      switch theme
    </button>
  {{/let}}
</template>

