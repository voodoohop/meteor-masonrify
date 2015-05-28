Package.describe({
  name: "voodoohop:masonrify",
  summary: "Easy Masonry Style Layouts using Packery and Blaze UI"
  version: "0.0.2"
  git: "https://github.com/voodoohop/meteor-masonrify.git"
});

Package.on_use(function (api) {

  api.use([
    'deps',
    'templating',
    'coffeescript',
    'underscore',
    'ui']
    , 'client');

  api.add_files(['isotope/isotope-v2.pkgd.js', 'imagesloaded/imagesloaded.pkgd.js'], 'client');
  api.add_files(['template.html'], 'client');
  api.add_files(['masonry_style.css'], 'client');
  api.add_files(['masonrify.coffee'], 'client');
  api.export("Masonrify", "client");
});
