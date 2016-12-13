Utils =
  matches: (element, selector) ->
    matchesSelector = element.matches ||
                      element.webkitMatchesSelector ||
                      element.mozMatchesSelector ||
                      element.msMatchesSelector
    matchesSelector.call(element, selector)


DEFAULTS =
  activeClass: 'is-shown'
  transitionClass: 'is-fading'


Modal =
  isShown: false

  init: (options) ->
    @options = Object.assign({}, DEFAULTS, options)
    @element = @options.element

    @attachHandlers()
    @

  attachHandlers: () ->
    @element.addEventListener 'transitionend', () =>
      if @element.classList.contains(@options.activeClass) and
          !@element.classList.contains(@options.transitionClass)
        @element.classList.remove(@options.activeClass)
    @

  show: () ->
    @element.classList.add(@options.activeClass)
    @forceReflow()
    @element.classList.add(@options.transitionClass)
    @isShown = true
    @

  hide: () ->
    @element.classList.remove(@options.transitionClass)
    @isShown = false
    @

  toggle: () ->
    @[if @isShown then 'hide' else 'show']()
    @

  forceReflow: () ->
    window.getComputedStyle(@element, null).display
    @


createModal = () ->
  Object.create(Modal)


document.addEventListener 'click', (event) ->
  { matches } = Utils

  if matches(event.target, '[data-toggle="modal"]')
    toggle = event.target
    componentId = toggle.getAttribute('data-component-id')

    unless componentId
      modal = createModal()
                .init
                  element: document.querySelector(toggle.getAttribute('data-target'))

      componentId = String(new Date().getTime())
      window._components ||= {}
      window._components[componentId] = modal
      toggle.setAttribute('data-component-id', componentId)

    modal = window._components[componentId]
    modal.toggle()
