part of w3guru;

List posts = querySelectorAll('.post');
var navPrevPost = querySelectorAll('.prev-post');
var navNextPost = querySelectorAll('.next-post');
const ms = const Duration(milliseconds: 800);

var inRightEffect = 'zoomInRight';
var outLeftEffect = 'fadeOutLeft';

var activePostId;


checkNextPost(){
  if(activePostId + 1 < posts.length){
    // return true;
    navNextPost.style.display = 'block';
  } else {
    // return false;
    navNextPost.style.display = 'none';
  }
}

checkPrevPost(){
  if(activePostId - 1 < 0){
    // return false;
    navPrevPost.style.display = 'none';
  } else {
    // return true;
    navPrevPost.style.display = 'block';
  }
}

deactivatePost(postId){
  var post = posts[postId];
  post.classes..remove(inRightEffect)
              ..remove('animted')
              ..add(outLeftEffect)
              ..toggle('animated',true);
  new Timer(ms,(){
    post.style.display = 'none';
  });
}

activatePost(post){
  post.style.display = 'block';
  post.classes..add(inRightEffect)
              ..toggle('animated',true);
  activePostId = posts.indexOf(post);
}


activateNextPost(){
  int nextPost = activePostId+1;
  if(nextPost < posts.length) {
    deactivatePost(activePostId);
    activatePost(posts[nextPost]);
    checkNextPost();
    checkPrevPost();

  }
}

activatePrevPost(){
  int prevPost = activePostId-1;
  if(prevPost >= 0) {
    deactivatePost(activePostId);
    activatePost(posts[prevPost]);
    checkNextPost();
    checkPrevPost();
  }
}

makePostsNavigation(){
  navNextPost.onClick.listen((event){
    activateNextPost();
  });

  navPrevPost.onClick.listen((event){
    activatePrevPost();
  });

}