
class Masonrify

  @instances= {}

  constructor: (container, options) ->
    options = _.extend({itemSelector: ".masonry_element", stamp: ".stamped"}, options)
    console.log("instantiating packery with options", options)
    @_ms = new Packery(container, options)

  addItems: (items) -> @_ms.addItems(items)
  appended: (div) -> @_ms.appended(div)
  refreshSize: (item) -> @_ms.fit(item)
  debouncedRelayout: _.debounce( (reload=false) ->
    if (@_ms)
      if (reload)
        @_ms.reloadItems()
      @_ms.layout()
  ,200)

  remove: (item) -> @_ms.remove(item[0])

  unStamp: (element,callback) ->
    @_ms.unstamp(element)
    callback() if callback?
    @debouncedRelayout(false)

  reStamp: (element, callback) ->
    @_ms.stamp(element)
    callback() if callback?
    @debouncedRelayout(false)

  on: (event, callback) ->
    @_ms.on(event, callback)

  off: (event, callback) ->
    @_ms.off(event, callback)


Meteor.startup ->
  getContainerId = (data) -> data.container ? data


  Template.masonryContainer.rendered = ->
    Masonrify.instances[this.data.id] = new Masonrify(this.firstNode, this.data)

  Template.masonryContainer.masonryContainerId = ->
      console.log("got masonry cont id", this.id)
      this.id
  Template.masonryElement.setContainerId = (arg1,arg2) ->
    console.log("setContainerId", this, arg1,arg2)
    return null
  Template.masonryElement.rendered = (arg1, arg2) ->
    console.log("masonryElement rendered", this)
    contId = getContainerId(this.data)
    element = this.firstNode
    Masonrify.instances[contId]?.appended(element)
    imagesLoaded(this.firstNode, -> Masonrify.instances[contId]?.debouncedRelayout())


  Template.masonryElement.destroyed = ->
    Masonrify.instances[this.data]?.debouncedRelayout(true)
