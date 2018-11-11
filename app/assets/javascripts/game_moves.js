$(function(){
  
  $('.piece_image').draggable({ 
    revert: true,
    cursor: 'grabbing'
    
  }) 
  
  $( "td" ).droppable
  ({
    
    drop: function( event, ui )
    {
      var game_id = $('#board').data('game_id');
      var piece_id = ui.helper[0].id
      var x = $(event.target).data('row')
      var y = $(event.target).data('col')
      var color = ui.helper[0].getAttribute('data-color')
      var type = ui.helper[0].getAttribute('data-type')
      
      // Current td position
      var square = this

      /* Pass current piece position to controller and retrieve new position
      after validation of move on the server */
      
      $.ajax
      ({
          type: 'GET',
          url: '/games/' + game_id + '/pieces/' + piece_id + '/move',
          dataType: 'json',
          data: { position_x: x,
          position_y: y,
          color: color,
          type: type,
          piece_id: piece_id }
      })
      
      .done(function(piece)
      {
        if (piece) {
          if (event.target.children.length > 0)
          {
            if (piece.color !== $.trim(event.target.children[0].getAttribute('data-color')))
            {
              alert('Piece Captured')
              var id = event.target.children[0].getAttribute('id')
              $("td .piece_image[data-piece_id=" + id + ']').remove();
              $(ui.draggable).detach().css({top: 0,left: 0}).appendTo(square);
              
            }
          }
          else if (event.target.children.length < 0)
          {
            if (piece.color == $.trim(event.target.children[0].getAttribute('data-color')))
            {
              alert('Same Team asshole')
            }
          } 
          else
          {
            $(ui.draggable).detach().css({top: 0,left: 0}).appendTo(square);
          }
        }
      })
      
    }
    
  });
});
