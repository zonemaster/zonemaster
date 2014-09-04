$(document).ready(function(){
  $('body').on('click','a.expand',function(e){
    var $a = $(e.target),
        $expand = $a.parentsUntil('.module').parent().find('.more'),
        $icon = $a;

    if($expand.hasClass('opened')){
      $icon.addClass('fa-plus-square-o').removeClass('fa-minus-square-o');
    } else {
      $icon.addClass('fa-minus-square-o').removeClass('fa-plus-square-o');
    }
    $expand.slideToggle().toggleClass('opened');
    
  });
});
