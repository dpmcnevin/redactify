// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Event.observe(window, 'load', function() {
  var fade=setTimeout("fadeout()",3500);
  var hide=setTimeout("$('flash').hide()",4800);
});

function fadeout(){
  new Effect.Opacity("flash", {duration:1.5, from:1.0, to:0.0});
}   
