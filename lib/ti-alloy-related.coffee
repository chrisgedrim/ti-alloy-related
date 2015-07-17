openFile = (uri) ->
    atom.workspace.open(uri)

running = false

module.exports =
  config:
      testFilePath:
          type: 'string'
          default: ''

  activate: ->
      @disposable = atom.commands.add 'atom-text-editor', 'ti-alloy-related:openRelated', => @openRelated()

  deactivate: ->
      @disposable.dispose();
      @disposable = null;

  openRelated: ->
    return unless editor = atom.workspace.getActiveTextEditor()

    uri = "#{editor.getPath()}"
    testFilePath = atom.config.get 'ti-alloy-related.testFilePath'

    if uri.match(/.*Spec\.js/)
        openFile(uri.replace(testFilePath + 'controllers/', 'app/controllers/').replace('Spec.js', '.js'))
        openFile(uri.replace(testFilePath + 'controllers/', 'app/styles/').replace('Spec.js', '.tss'))
        openFile(uri.replace(testFilePath + 'controllers/', 'app/views/').replace('Spec.js', '.xml'))
    else if uri.match(/.*\.js/)
        openFile(uri.replace('app/controllers/', 'app/views/').replace('.js', '.xml'))
        openFile(uri.replace('app/controllers/', 'app/styles/').replace('.js', '.tss'))
        openFile(uri.replace('app/controllers/', testFilePath + 'controllers/').replace('.js', 'Spec.js'))
    else if uri.match(/.*\.tss/)
        openFile(uri.replace('app/styles/', 'app/controllers/').replace('.tss', '.js'))
        openFile(uri.replace('app/styles/', 'app/views/').replace('.tss', '.xml'))
        openFile(uri.replace('app/styles/', testFilePath + 'controllers/').replace('.tss', 'Spec.js'))
    else if uri.match(/.*\.xml/)
        openFile(uri.replace('app/views/', 'app/controllers/').replace('.xml', '.js'))
        openFile(uri.replace('app/views/', 'app/styles/').replace('.xml', '.tss'))
        openFile(uri.replace('app/views/', testFilePath + 'controllers/').replace('.xml', 'Spec.js'))
