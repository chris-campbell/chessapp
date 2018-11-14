App.piece = App.cable.subscriptions.create "PieceChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    piece = $("td .piece_image[data-piece_id=" + data.piece_id + ']')
    square = $(".ui-droppable[data-row=" + data.position_x + '][data-col=' + data.position_y + ']')

    if piece
      if square[0].children.length > 0
        squarePieceColor = square[0].children[0].getAttribute('data-color')
        if data.color != $.trim(squarePieceColor)
          id = square[0].children[0].getAttribute('id')
          $('td .piece_image[data-piece_id=' + id + ']').remove()
          (piece).appendTo(square)
      else if square[0].children.length < 0
        if data.color == $.trim(squarePieceColor)
          alert 'Same Team asshole'
      else
        $(piece).detach().css(
          top: 0
          left: 0).appendTo square

        
    
    
