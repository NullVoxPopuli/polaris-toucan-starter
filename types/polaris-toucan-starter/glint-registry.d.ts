import "@glint/environment-ember-loose";
import "@glint/environment-ember-loose/native-integration";
import "ember-page-title/glint";
import 'ember-browser-services/types';

// import type { ComponentLike, HelperLike, ModifierLike } from "@glint/template";

import Welcome from 'polaris-toucan-starter/components/welcome';
import ThemeSwitcher from 'polaris-toucan-starter/components/theme-switcher';

declare module "@glint/environment-ember-loose/registry" {
  export default interface Registry {
    // Examples
    // state: HelperLike<{ Args: {}, Return: State }>;
    // attachShadow: ModifierLike<{ Args: { Positional: [State['update']]}}>;
    Welcome: typeof Welcome;
    ThemeSwitcher: typeof ThemeSwitcher;
  }
}
