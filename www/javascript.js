$(document).ready( () => {

  // Set tabindex = 0 for all elements to allow tabbing navigation
  $('[tabindex]').each(function(i){
    $(this).attr("tabindex", 0);
  });
  
  $(document).on('shown.bs.tab', (x) => {
     $('[tabindex]').each(function(i){
        $(this).attr("tabindex", 0);
     });
  });
  
});