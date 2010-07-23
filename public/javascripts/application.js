
$(function() {
  if ($("#flash") && !$("#flash").hasClass("error")) {
    var fade=setTimeout("fadeout()",3500);
    var hide=setTimeout("$('#flash').hide()",4800);
  }
});

function fadeout() {
  $("#flash").hide("fade", {}, 1000)
}   

function loading(section) {
  $("#" + section).update("loading...")
}

function reply_to_tweet(screen_name, tweet_id) {
  $("#new_tweet").val("@" + screen_name + " ");
  $("#tweet_in_reply_to_status_id").val(tweet_id);
  $("#new_tweet").focus();
}

