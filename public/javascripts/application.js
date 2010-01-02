
Event.observe(window, 'load', function() {
  if ($("flash")) {
    var fade=setTimeout("fadeout()",3500);
    var hide=setTimeout("$('flash').hide()",4800);
  }
});

function fadeout() {
  new Effect.Opacity("flash", {duration:1.5, from:1.0, to:0.0});
}   

function loading(section) {
  $(section).update("loading...")
}

