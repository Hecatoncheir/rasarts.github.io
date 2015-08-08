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
    // print(key);

    if(key == 104 || key == 1088){
      activatePrevPost();
    }
    if(key == 106 || key == 1086){
      window.scrollTo(0, currentPosition + scrollStep); currentPosition = window.scrollY;
    }
    if(key == 107 || key == 1083){
      window.scrollTo(0, currentPosition - scrollStep);
      currentPosition = window.scrollY;
    }
    if(key == 108 || key == 1076){
      activateNextPost();
    }

    // switch(key){
    //   case(104):
    //     activatePrevPost();
    //   break;
    //   case(106):
    //     window.scrollTo(0, currentPosition + scrollStep); currentPosition = window.scrollY;
    //   break;
    //   case(107):
    //     window.scrollTo(0, currentPosition - scrollStep);
    //     currentPosition = window.scrollY;
    //   break;
    //   case(108):
    //     activateNextPost();
    //   break;
    // }
  });
}
