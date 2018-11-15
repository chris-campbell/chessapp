$ ->
  $('.piece_image').draggable
    revert: true
    cursor: 'grabbing'
  $('td').droppable drop: (event, ui) ->
    game_id = $('#board').data('game_id')
    piece_id = ui.helper[0].id
    x = $(event.target).data('row')
    y = $(event.target).data('col')
    color = ui.helper[0].getAttribute('data-color')
    type = ui.helper[0].getAttribute('data-type')
    player = ui.helper[0].getAttribute('data-player')
    
    $.ajax
      type: 'GET'
      url: '/games/' + game_id + '/pieces/' + piece_id + '/move'
      dataType: 'json'
      data:
        position_x: x
        position_y: y
        color: color
        type: type
        player: player
        piece_id: piece_id
    return
  return