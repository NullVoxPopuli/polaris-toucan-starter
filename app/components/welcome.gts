import { TOC } from '@ember/component/template-only';
import { TrackedObject } from 'tracked-built-ins';

import { modifier } from 'ember-modifier';
import { resource } from 'ember-resources';


import { Features, References } from './features-references';

/**
  * Example of defining a Resource inline
  */
const Clock = resource(({ on }) => {
  let time = new TrackedObject({ current: new Date() });
  let interval = setInterval(() => {
    time.current = new Date();
  }, 1000);

  on.cleanup(() => clearInterval(interval));

  let formatter = new Intl.DateTimeFormat('en-US', {
    hour: 'numeric',
    minute: 'numeric',
    second: 'numeric',
    hour12: false,
  });

  return () => formatter.format(time.current);
});

/**
  * Example of defining a modifier inline
  */
const textEffect = modifier(element => {
  console.log('TODO: a visual fancyness!');
}, { eager: false });

const FancyText: TOC<{
  Blocks: {
    default: [];
  }
}> =
  <template>
    <span {{textEffect}}>{{yield}}</span>
  </template>;


/**
  * Examplet typed template-only component
  */
const Welcome: TOC<{}> = <template>
  <h1 class="type-4xl">Welcome to <FancyText>Polaris</FancyText></h1>

  <main class="grid gap-4">

    <span class="p-4">
      Now: {{Clock}}<br>
    </span>

    <hr>

    <Features />
    <References />
  </main>
</template>

export default Welcome;
