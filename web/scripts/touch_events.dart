part of w3guru;

makeTouchEvents() {
  var xStart;
  var xUpdate;

  window.onTouchStart.listen((event) {
    xStart = event.touches[0].client.x;
  });

  window.onTouchMove.listen((event) {
    xUpdate = event.touches[0].client.x;
  });

  window.onTouchEnd.listen((event) {

    if (xUpdate > xStart) {
      /* left swipe */
      activatePrevPost();
    } else {
      /* right swipe */
      activateNextPost();
    }

    xStart = null;
  });
}
