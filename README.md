meteor-masonrify
================

Easily add Masonry-style dynamic layouts to Meteor. Depends on the new Blaze UI.

Currently uses Isotope as the layouting engine.

usage:

```sh
$ mrt add masonrify
```

The container div is created using the #masonryContainer block helper. For each masonry instance you wish to use define one id for the container, e.g. id="MasonryContainer".

You can pass options directly to packery (http://packery.metafizzy.co/options.html). It is a good idea to define the columnWidth here for example.

```html
      {{#masonryContainer columnWidth=115 transitionDuration="0.1s" id="MasonryContainer" }}
        ...
      {{/masonryContainer}}
```

Use the {{#masonryElement}} block helper to create the individual elements to be layouted. Pass the id previously defined...

      {{#masonryContainer columnWidth=115 transitionDuration="0.1s" gutter=2 id="MasonryContainer" }}
         {{#each exampleContentCollection}}
           {{#masonryElement "MasonryContainer"}}
             ... content ...
           {{/masonryElement}}
         {{/each}}
      {{/masonryContainer}}


