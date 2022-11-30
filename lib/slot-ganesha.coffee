SlotGaneshaView = require './slot-ganesha-view'
{CompositeDisposable} = require 'atom'

module.exports = SlotGanesha =
  slotGaneshaView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @slotGaneshaView = new SlotGaneshaView(state.slotGaneshaViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @slotGaneshaView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'slot-ganesha:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @slotGaneshaView.destroy()

  serialize: ->
    slotGaneshaViewState: @slotGaneshaView.serialize()

  toggle: ->
    console.log 'SlotGanesha was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
