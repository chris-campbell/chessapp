$(function() {
  $('.piece_image').draggable({
    revert: true,
    cursor: 'grabbing'
  });
  $('td').droppable({drop(event, ui) {
    const game_id = $('#board').data('game_id');
    const turn = $('#board').data('turn');
    const piece_id = ui.helper[0].id;
    const x = $(event.target).data('row');
    const y = $(event.target).data('col');
    const color = ui.helper[0].getAttribute('data-color');
    const type = ui.helper[0].getAttribute('data-type');
    const player = ui.helper[0].getAttribute('data-player');

    $.ajax({
      type: 'PUT',
      url: "/games/" + game_id + "/pieces/" + piece_id + "/move",
      dataType: 'json',
      data: {
        position_x: x,
        position_y: y,
        color: color,
        type: type,
        player: player,
        turn: turn,
        piece_id: player
      }
    });
  }
  
  });
});
        
    
    
