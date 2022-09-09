import { TOC } from '@ember/component/template-only';

const ExternalLink: TOC<{
  Args: { href: string },
  Blocks: { default: [] }
}> = <template>
  <a
    href={{@href}}
    target="_blank"
    rel="noopener nofollow noreferrer"
    class="inline-block relative underline focusable-outer
      focus:text-primary-hover hover:text-primary-hover active:text-primary-pressed text-primary-idle"
  >
    {{yield}}
  </a>
</template>;

export const Features = <template>

  <section class="grid gap-4">
    <h2 class="type-2xl">New features</h2>

    <ul class="list-disc pl-4 grid gap-3">
      <li>Any function is a helper</li>
      <li>Resources (built-in)</li>
      <li>Modifiers (built-in)</li>
      <li>tracked-built-ins (built-in)</li>
      <li>strictest embroider -- only pay for what you import</li>
      <li>gts / gjs component format</li>
      <li>and more!</li>
    </ul>
  </section>

</template>;

export const References = <template>
  <section class="grid gap-4">
    <h2 class="type-2xl">References</h2>

    <ul class="list-disc pl-4 grid gap-3">
      <li>
        <ExternalLink @href="https://discuss.emberjs.com/t/ember-modern-css/19614">
          How to setup Tailwind 3
        </ExternalLink>
      </li>
      <li>
       <ExternalLink @href="https://github.com/crowdstrike/ember-toucan-styles">
         The Theme and theme utilities
       </ExternalLink>
      </li>
      <li>
        <ExternalLink @href="https://github.com/NullVoxPopuli/ember-resources/">
          ember-resources
        </ExternalLink>
      </li>
      <li>
        <ExternalLink @href="https://github.com/ember-modifier/ember-modifier">
          ember-modifier
        </ExternalLink>
      </li>
      <li>
        <ExternalLink @href="https://emberjs.com/editions/">
          Information on "Editions"
        </ExternalLink>
      </li>
      <li>
        <ExternalLink @href="https://github.com/ember-template-imports/ember-template-imports/">
          How to setup gjs / gts in your own app
        </ExternalLink>
      </li>
      <li>
        <ExternalLink @href="https://typed-ember.gitbook.io/glint/">
          How to setup Glint
        </ExternalLink>
      </li>
    </ul>
  </section>
</template>;
