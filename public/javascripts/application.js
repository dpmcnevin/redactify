
Event.observe(window, 'load', function() {
  if ($("flash") && !$("flash").hasClassName("error")) {
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

function reply_to_tweet(screen_name, tweet_id) {
  $("new_tweet").value = "@" + screen_name + " ";
  $("tweet_in_reply_to_status_id").value = tweet_id;
  $("new_tweet").focus();
}

