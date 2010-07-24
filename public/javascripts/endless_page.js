// endless_page.js
var currentPage = 1;

function checkScroll() {
  if (nearBottomOfPage()) {
		if ($("#get_more a")) {
			$("#get_more a").callRemote();
			// alert("going to load more!");
		}
  }
 setTimeout("checkScroll()", 3000);
}

function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 150;
}

function scrollDistanceFromBottom(argument) {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
}

function pageHeight() {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

$(function() {
  // Disable this for now.
  // checkScroll(); 
});