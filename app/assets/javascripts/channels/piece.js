/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
App.piece = App.cable.subscriptions.create("PieceChannel", {
  connected() {},
  // Called when the subscription is ready for use on the server

  disconnected() {},
  // Called when the subscription has been terminated by the server

  received(data) {
    const piece = $(`td .piece_image[data-piece_id=${data.piece_id}]`);
    const square = $(`.ui-droppable[data-row=${data.position_x}][data-col=${data.position_y}]`);

    if (piece) {
      let squarePieceColor;
      $('.noticer p').html(data.turn[0].toUpperCase() + data.turn.substring(1) + ' Turn');
      if (square[0].children.length > 0) {
        squarePieceColor = square[0].children[0].getAttribute('data-color');
        if (data.color !== $.trim(squarePieceColor)) {
          const id = square[0].children[0].getAttribute('id');
          $(`td .piece_image[data-piece_id=${id}]`).remove();
          return (piece).appendTo(square);
        }
      }
      else if (data.color === $.trim(squarePieceColor)) {
        return alert('Same Team asshole');
      }
      else {
        return $(piece).detach().css({ top: 0, left: 0 }).appendTo(square);
      }
    }
  }
});
