// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery.min
//= require jquery-ui.min
//= require bootstrap-alert
//= require bootstrap-tab
//= require jquery.tokeninput
//= require formToWizard
//= require_tree ./admin

$(document).ready(function(){
  $(".alert-message .close").click(function(){
    $(".alert-message").alert('close');
  });

  $("#initiative_topic_tokens").tokenInput("/admin/topics.json", {
      theme: "facebook",
      prePopulate: $("#initiative_topic_tokens").data("pre"),
      crossDomain: false
  });

  $("#initiative_presented_by_token").tokenInput("/admin/representatives.json", {
      theme: "facebook",
      prePopulate: $("#initiative_presented_by_token").data("pre"),
      crossDomain: false
  });

  $("#representative_commission_tokens").tokenInput("/admin/commissions.json", {
      theme: "facebook",
      prePopulate: $("#representative_commission_tokens").data("pre"),
      crossDomain: false
  });

  $("#representative_topic_tokens").tokenInput("/admin/topics.json", {
      theme: "facebook",
      prePopulate: $("#representative_topic_tokens").data("pre"),
      crossDomain: false
  });
  
  $("#initiative_commission_tokens").tokenInput("/admin/commissions.json", {
      theme: "facebook",
      prePopulate: $("#initiative_commission_tokens").data("pre"),
      crossDomain: false
  });

  $('#initiatives_order').sortable({
    type: 'post',
    update: function(){
      var url = $('#initiatives_order').data('url');
      var authenticity_token = $('#initiatives_order').data('authenticity-token');
      $.ajax({async:true,
        type: 'post',
        complete:function(request){
          $("#initiatives_order").effect("highlight") },
          data:$("#initiatives_order").sortable('serialize') + '&authenticity_token=' + encodeURIComponent(authenticity_token),
          dataType:'script',
          url: url})
      }
  });
  $("#initiatives_order").disableSelection();
});