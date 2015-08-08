part of w3guru;

int scrollStep = 60;

var currentPosition = window.scrollY;

makeVimNavigation(){

  window.onScroll.listen((event){
    currentPosition = window.scrollY;
  });

  window.addEventListener('keypress', (event){
    // event.stopPropagation();
    var key = event.keyCode;
    print(key);

    switch(key){
      case(104):
        activatePrevPost();
      break;
      case(106):
        window.scrollTo(0, currentPosition + scrollStep);
        currentPosition = window.scrollY;
      break;
      case(107):
        window.scrollTo(0, currentPosition - scrollStep);
        currentPosition = window.scrollY;
      break;
      case(108):
        activateNextPost();
      break;
    }
  });
}
