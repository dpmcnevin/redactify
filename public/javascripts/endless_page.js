// endless_page.js
var currentPage = 1;

function checkScroll() {
  if (nearBottomOfPage()) {
		if ($("#get_more_link")) { 
			$("#get_more_link").onclick();
			// alert("going to load more!" + $("get_more_link").getAttribute("onclick"));
		}
  }
 	setTimeout("checkScroll()", 500);
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

$(document).load(checkScroll);