// Thanks to: http://www.alanedwardes.com/posts/endless-page-scroll-with-jquery/

$(window).scroll(function(){
	if($(document).scrollTop()+$(window).height() == $(document).height()){
		$("#get_more a").callRemote();
	}
});