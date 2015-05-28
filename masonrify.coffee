
class Masonrify

  @instances= {}

  constructor: (container, options) ->
    options = _.extend({itemSelector: ".masonry_element", stamp: ".stamped", masonry: options}, options)
    @_ms = new Isotope(container, options)
    @_container = container

  addItems: (items) -> @_ms.addItems(items)
  appended: (div) -> @_ms.appended(div)
  refreshSize: (item) -> @_ms.fit(item)
  debouncedRelayout: _.debounce( ()->
    #console.log("masonry debounced")
    if (@_ms)
      #if (true)
        #console.log("masonry reloading and sorting original order")
      #$(@_container).isotope( 'reloadItems' ).isotope({ sortBy: 'original-order' }).isotope('reLayout');
      #@_ms.reloadItems()
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


#Meteor.startup ->
getContainerId = (data) -> data.container ? data

Template.masonryContainer.rendered = ->
  #console.log(this.data)
  Masonrify.instances[this.data.id] = new Masonrify(this.firstNode, this.data)

Template.masonryContainer.masonryContainerId = ->
    #console.log("got masonry cont id", this.id)
    this.id
Template.masonryElement.setContainerId = (arg1,arg2) ->
  #console.log("setContainerId", this, arg1,arg2)
  return null
Template.masonryElement.rendered = (arg1, arg2) ->
  #console.log("masonryElement rendered", this)
  contId = getContainerId(this.data)
  element = this.firstNode
  Masonrify.instances[contId]?.appended(element)
  #Masonrify.instances[contId]?.debouncedRelayout()
  imagesLoaded(this.firstNode, -> Masonrify.instances[contId]?.debouncedRelayout())


Template.masonryElement.destroyed = ->
    Masonrify.instances[getContainerId(this.data)]?.debouncedRelayout(true)
