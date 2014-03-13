Package.describe({
  summary: "Easy Masonry Style Layouts using Packery and Blaze UI"
});

Package.on_use(function (api) {

  api.use([
    'deps',
    'templating',
    'coffeescript',
    'underscore',
    'ui']
    , 'client');

  api.add_files(['packery/packery.pkgd.min.js', 'packery/imagesloaded.js'], 'client');
  api.add_files(['template.html'], 'client');
  api.add_files(['masonry_style.css'], 'client');
  api.add_files(['masonrify.coffee'], 'client');
  api.export("Masonrify", "client");
});
