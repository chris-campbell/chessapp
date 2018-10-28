$(function(){
  
  $('.piece_image').draggable({
    revert: true
  }) 
  
  $( "td" ).droppable({
    drop: function( event, ui ) {
      accept: ".piece_id"
      var game_id = $('#board').data('game_id');
      var piece_id = ui.helper[0].id
      var x = $(event.target).data('row')
      var y = $(event.target).data('col')

      // Current td position
      var square = this
      
      // Pass current piece position to controller and retrieve new position
      // after validation of move on the server
      $.ajax({
        type: 'GET',
        url: '/games/' + game_id + '/pieces/' + piece_id + '/move',
        dataType: 'json',
        data: { position_x: x,
        position_y: y, 
        piece_id: piece_id },
        success: function(data) {
          if (data) {
            $(ui.draggable).css({top: 0,left: 0}).appendTo(square);
          } else {
            alert('Invalid Move, try again!')
          }
        }
      })
    }
  });
});

