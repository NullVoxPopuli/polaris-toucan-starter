import * as THREE from 'three';
import { modifier } from 'ember-modifier';

import type { TOC } from '@ember/component/template-only';

const setup = modifier(element => {
  let aspectRatio = 1.2;
  const camera = new THREE.PerspectiveCamera(
    70,
    aspectRatio,
    0.01,
    10
  );
  camera.position.z = 2;

  const scene = new THREE.Scene();

  const geometry = new THREE.BoxGeometry(1,1,1);
  const material = new THREE.MeshNormalMaterial();

  const mesh = new THREE.Mesh(geometry, material);
  scene.add(mesh);

  const renderer = new THREE.WebGLRenderer({ antialias: true });

  renderer.setSize(element.clientWidth, element.clientHeight);
  renderer.setAnimationLoop(animation);
  element.appendChild(renderer.domElement);

  function animation(time: number) {
    mesh.rotation.x = time / 2000;
    mesh.rotation.y = time / 1000;

    renderer.render(scene, camera);
  }
}, { eager: false });


interface Signature {
  Blocks: [];
}

export const ThreeDemo: TOC<Signature> = <template>
  <div style="width: 500px; height: 500px;" {{setup}}></div>
</template>;

export default ThreeDemo;
