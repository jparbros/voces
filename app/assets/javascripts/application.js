// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery.min
//= require jquery_ujs
//= require jquery-ui.min
//= require jquery.tweet
//= require jquery.sidecontent
//= require bootstrap-twipsy
//= require bootstrap-modal
//= require bootstrap-popover
//= require jquery.jcarousel.min
//= require jquery.trimtext
//= require entiende


$(document).ready(function(){
  $('.carousel').carousel({
    direction: "vertical",
    dispItems: 30,
    loop: true,
    nextBtn: '<span class="button-down">&nbsp;</span>',
    prevBtn: '<span class="button-up">&nbsp;</span>'
  });

  $('#comment_comment').keyup(function(){
   $('#comment_comment').trimTxt();
  });

  $('input.submit').click(function(event) {
    event.preventDefault();

    var comment_author = $('form#new_comment input#comment_author');
    var comment_email = $('form#new_comment input#comment_email');
    var comment_comment = $('form#new_comment #comment_comment');

    if (comment_author.val() == "")
      comment_author.addClass('error');

    if (comment_email.val() == "")
      comment_email.addClass('error');

    if (comment_comment.val() == "")
      comment_comment.addClass('error');

    if ((comment_author.val() != "") && (comment_email.val() != "") && (comment_comment.val() != ""))
      $(this).parent().submit();

  });

  $(".side").sidecontent({opacity: 1, pulloutpadding: 20});
});


