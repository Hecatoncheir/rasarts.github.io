part of w3guru;

makeVimNavigation(){
  window.addEventListener('keyup', (event){
    // event.stopPropagation();

    if(event.keyCode == 72){
      navPrevPost.click();
    }
    if(event.keyCode == 76){
      navNextPost.click();
    }
  });
}
