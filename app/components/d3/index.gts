import * as d3 from 'd3';
import { modifier } from 'ember-modifier';

import type { TOC } from '@ember/component/template-only';

import { sample } from './data';


const d3Demo = modifier((element: SVGElement) => {
  const svg = d3.select(element);

  const margin = 80;
  const width = 1000 - 2 * margin;
  const height = 600 - 2 * margin;

  const chart = svg.append('g')
    .attr('transform', `translate(${margin}, ${margin})`);

  const xScale = d3.scaleBand()
    .range([0, width])
    .domain(sample.map((s) => s.language))
    .padding(0.4);

  const yScale = d3.scaleLinear()
    .range([height, 0])
    .domain([0, 100]);

  const makeYLines = () => d3.axisLeft()
    .scale(yScale)

  chart.append('g')
    .attr('transform', `translate(0, ${height})`)
    .call(d3.axisBottom(xScale));

  chart.append('g')
    .call(d3.axisLeft(yScale));

  chart.append('g')
    .attr('class', 'grid')
    .call(makeYLines()
      .tickSize(-width, 0, 0)
      .tickFormat('')
    );

  const barGroups = chart.selectAll()
    .data(sample)
    .enter()
    .append('g');

  barGroups
    .append('rect')
    .attr('class', 'bar')
    .attr('x', (g) => xScale(g.language))
    .attr('y', (g) => yScale(g.value))
    .attr('height', (g) => height - yScale(g.value))
    .attr('width', xScale.bandwidth())
    .on('mouseenter', function (actual, i) {
      d3.selectAll('.value')
        .attr('opacity', 0)

      d3.select(this)
        .transition()
        .duration(300)
        .attr('opacity', 0.6)
        .attr('x', (a) => xScale(a.language) - 5)
        .attr('width', xScale.bandwidth() + 10)

      const y = yScale(actual.value)

      chart.append('line')
        .attr('id', 'limit')
        .attr('x1', 0)
        .attr('y1', y)
        .attr('x2', width)
        .attr('y2', y)

      barGroups.append('text')
        .attr('class', 'divergence')
        // .attr('x', (a) => xScale(a.language) + xScale.bandwidth() / 2)
        .attr('y', (a) => yScale(a.value) + 30)
        .attr('fill', 'white')
        .attr('text-anchor', 'middle')
        .text((a, idx) => {
          const divergence = (a.value - actual.value).toFixed(1)

          let text = '';
          if (divergence > 0) text += '+';
          text += `${divergence}%`;

          return idx !== i ? text : '';
        });

    })
    .on('mouseleave', function () {
      d3.selectAll('.value')
        .attr('opacity', 1)

      d3.select(this)
        .transition()
        .duration(300)
        .attr('opacity', 1)
        .attr('x', (a) => xScale(a.language))
        .attr('width', xScale.bandwidth());

      chart.selectAll('#limit').remove();
      chart.selectAll('.divergence').remove();
    });

  barGroups
    .append('text')
    .attr('class', 'value')
    .attr('x', (a) => xScale(a.language) + xScale.bandwidth() / 2)
    .attr('y', (a) => yScale(a.value) + 30)
    .attr('text-anchor', 'middle')
    .text((a) => `${a.value}%`);

  svg
    .append('text')
    .attr('class', 'label')
    .attr('x', -(height / 2) - margin)
    .attr('y', margin / 2.4)
    .attr('transform', 'rotate(-90)')
    .attr('text-anchor', 'middle')
    .text('Love meter (%)');

  svg.append('text')
    .attr('class', 'label')
    .attr('x', width / 2 + margin)
    .attr('y', height + margin * 1.7)
    .attr('text-anchor', 'middle')
    .text('Languages');

  svg.append('text')
    .attr('class', 'title')
    .attr('x', width / 2 + margin)
    .attr('y', 40)
    .attr('text-anchor', 'middle')
    .text('Most loved programming languages in 2018');

  svg.append('text')
    .attr('class', 'source')
    .attr('x', width - margin / 2)
    .attr('y', height + margin * 1.7)
    .attr('text-anchor', 'start')
    .text('Source: Stack Overflow, 2018');
});

interface Signature {
  Blocks: [];
}

export const D3Demo: TOC<Signature> = <template>
  <div id="container"><svg {{d3Demo}} /></div>
  <style>
    div#container {
      width: 1000px;
      height: 600px;
      margin: auto;
      background-color: #2F4A6D;
    }

    svg {
      width: 100%;
      height: 100%;
    }

    .bar {
      fill: #80cbc4;
    }

    text {
      font-size: 12px;
      fill: #fff;
    }

    path {
      stroke: gray;
    }

    line {
      stroke: gray;
    }

    line#limit {
      stroke: #FED966;
      stroke-width: 3;
      stroke-dasharray: 3 6;
    }

    .grid path {
      stroke-width: 0;
    }

    .grid .tick line {
      stroke: #9FAAAE;
      stroke-opacity: 0.3;
    }

    text.divergence {
      font-size: 14px;
      fill: #2F4A6D;
    }

    text.value {
      font-size: 14px;
    }

    text.title {
      font-size: 22px;
      font-weight: 600;
    }

    text.label {
      font-size: 14px;
      font-weight: 400;
    }

    text.source {
      font-size: 10px;
    }
  </style>
</template>;

export default D3Demo;
