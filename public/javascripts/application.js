
// When the DOM is ready, run these
$(function() {
  
  // Remove and hide the flash after 3.5 seconds
  if ($("#flash") && !$("#flash").hasClass("error")) {
    var fade=setTimeout("$('#flash').fadeOut()",3500);
    var hide=setTimeout("$('#flash').hide()",4800);
  }
  
  // Watch the post tweet input and update the character count
  $("#new_tweet").live("keyup", function() {
		var tl = this.value.length;
		$("#remaining_characters").text(140 - tl);
		
		if (tl > 140) {
			$("#remaining_characters").addClass("over");
		} else if (tl <= 140 && $("#remaining_characters").hasClass("over")) {
				$("#remaining_characters").removeClass("over");
		}
	});
	
	// Check to make sure the tweet isn't over 140 characters
	$("#new_tweet_form").live("submit", function(post_tweet) { 
		if ($("#new_tweet").value.length > 140) { 
			alert("Status update is too long"); 
			post_tweet.stop();
		} else {
		  $("#post_tweet_loading").show();
		}
	});
  
  // Remove the new class for new tweets when hovering over them
  $(".tweet.new").live("hover", function() {
    $(this).removeClass("new");
    set_page_title();
  });
  
  // Watch for remote calls to "get more"
  $("#get_more")
    .live("ajax:loading", function() { 
      $("#get_more").replaceWith("<div id='get_more'>loading</div>");
      return false;
    })
    .live("ajax:success", function(status, data, xhr) {
      $("#get_more").replaceWith(data);
      update_rate_limit();
    });
  
  // Show controls when hovering over a tweet  
  $(".tweet").live("mouseover", function() {
    $(this).find(".hidden_controls").show();
  });
  
  // Hide controls when mousing out
  $(".tweet").live("mouseout", function() {
    $(this).find(".hidden_controls").hide();
  });
  
  // Show a redacted tweet
  $(".show_redacted_tweet")
    .live("ajax:success", function(status, data, xhr) {
      $(this).parents("div.tweet").replaceWith(data);
      update_rate_limit();
    });
      
  // Update trends
  $("#update_trends")
    .live("ajax:success", function(status, data, xhr) {
      $("#twitter_trends").html(data);
    });
    
  // Reply
  $(".reply")
    .live("click", function() {
      var tweet = $(this).parents("div.tweet");
      var tweet_id = tweet.attr("data-tweet");
      var screen_name = tweet.attr("data-screen_name");
      $("#new_tweet").val("@" + screen_name + " ");
      $("#tweet_in_reply_to_status_id").val(tweet_id);
      $("#new_tweet").focus();
    });
      
});

// Set the reply_to_status_id and update the post new tweet box with the user's name
function reply_to_tweet(screen_name, tweet_id) {
  $("#new_tweet").val("@" + screen_name + " ");
  $("#tweet_in_reply_to_status_id").val(tweet_id);
  $("#new_tweet").focus();
}

// TODO update the rate limit status
function update_rate_limit() {
   $.ajax({
     url: "/rate_limit",
     type: "PUT",
     success: function(data) {
       $("#rate_limit").html(data);
     }
   })
}

// Load new tweets every 90 seconds
function check_new_tweets (url) {
  setInterval("load_new_tweets('"+url+"')", 90000)
  // setInterval("load_new_tweets('"+url+"')", 5000)  
  // setTimeout("load_new_tweets('"+url+"')", 2000)
}

function load_new_tweets(url) {
  $.ajax({
    url: url,
    beforeSend: function() {  $("#new_tweets_loading").show(); },
    complete: function() {  $("#new_tweets_loading").hide(); },
    type: 'PUT', 
    success: function(html) {
      $("#updated_tweets").append(html); 
      update_rate_limit();
      set_page_title();
    } 
  })
}

function set_page_title() {
  var new_tweets = $(".tweet.new").size()
  if (new_tweets > 0) {
    document.title = "Redactify ("+ new_tweets + ")";
  } else {
    document.title = "Redactify"
  }
}

function blurInput(selector, default_text) {

  // Remove defalt text and highlight box when selected
  $(selector).focus(function() {
    if (this.value == default_text) {
      $(selector).removeClass("default_input");
      this.value = "";
    }
  });

  // put default textback and lighten the box when de-selected
  $(selector).blur(function() {
    if (this.value == "") {
      $(selector).addClass("default_input");
      this.value = default_text;
    }
  });
}

function show_spoiler_action() {
  // Hover actions for saved searches list.

  $("#spoiler_tags li").hover(
    function() {
      $(this).find(".spoiler_action").show();
    },
    function() {
      $(this).find(".spoiler_action").hide();
    }
  );
  
}
