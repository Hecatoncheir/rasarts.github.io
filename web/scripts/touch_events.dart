part of w3guru;

makeTouchEvents() {
  var xStart,
      xUpdate;
  var topScrollPoint,
      updatedTopScrollPoint;

  window.onTouchStart.listen((event) {
    topScrollPoint = window.scrollY;
    xStart = event.touches[0].client.x;
  });

  window.onTouchMove.listen((event) {
    updatedTopScrollPoint = window.scrollY;
    xUpdate = event.touches[0].client.x;
  });

  window.onTouchEnd.listen((event) {

    var toDownScroll = topScrollPoint > updatedTopScrollPoint;
    var toTopScroll = topScrollPoint < updatedTopScrollPoint;

    if(!toDownScroll && !toTopScroll ){
      if (xUpdate > xStart) {
        /* left swipe */
        activatePrevPost();
      } else {
        /* right swipe */
        activateNextPost();
      }
    }

    topScrollPoint = 0;
    xStart = 0;
    xUpdate = 0;
  });
}
