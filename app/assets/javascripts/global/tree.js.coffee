$ ->
  $('.tree-div').each ->
    tree = $(this)
    treeWrapper = tree.parents('.tree-wrapper')

    tree
      .on 'check_node.jstree', (e, data) ->
        data.instance.open_all data.node
      .on 'uncheck_node.jstree', (e, data) ->
        data.instance.close_all data.node
      .jstree
        core: themes:
          icons: false
#          dots: false
        checkbox:
          tie_selection: false
          keep_selected_style: false
        plugins: [ 'checkbox' ]

    tree.jstree('open_all')
    tree.find('.jstree-checked').each ->
      tree.jstree('check_node', $(this))
    tree.find('.jstree-node').each ->
      if $(this).find('.jstree-checked').length == 0
        tree.jstree('close_node', $(this))

  $('.tree-button').click ->
    treeWrapper = $(this).parents('.tree-wrapper')

    $.fancybox(
      treeWrapper.find('.tree-div-wrapper')
      wrapCSS: "fancybox-dialog"
      parent: 'body'
      padding: 0
      autoSize: false
      width: 400
      maxHeight: 555
      helpers: { title: null, overlay: { locked: true } }
      afterClose: ->
        checkedNodes = []
        $.each treeWrapper.find('.tree-div').jstree('get_checked', true), (index, node) ->
          if node.children.length == 0
            checkedNodes.push(node)

        captionSpan = treeWrapper.find('.tree-button span')
        if checkedNodes.length == 0
          caption = treeWrapper.find('.tree-button').data('caption')
          captionSpan.html(caption).removeClass('selected')
        else
          captionSpan.html(checkedNodes.length + ' selected').addClass('selected')

        hiddenValues = treeWrapper.find('.hidden-values')
        hiddenValues.html('')
        hiddenValueTemplate = treeWrapper.find('#hidden-value-template')
        $.each checkedNodes, (index, node) ->
          hiddenValueTemplate.clone().removeAttr('id').val(node.data.id).appendTo(hiddenValues)
    )

    false

  updateTreeDivHeight = ->
    $('.tree-div').css 'height', if $(window).height() - 140 < 455 then $(window).height() - 140 else 455

  updateTreeDivHeight()
  $(window).resize ->
    updateTreeDivHeight()

$(document).on 'click', '.done', ->
  $.fancybox.close()

$(document).on 'click', '.deselect-all', ->
  tree = $(this).parents('.tree-div-wrapper').find('.tree-div')
  $.each tree.jstree('get_checked', true), (index, node) ->
    tree.jstree('uncheck_node', node)
  tree.jstree('close_all')
