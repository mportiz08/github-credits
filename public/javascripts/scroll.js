$(document).ready(function() {
  $('#container').infinitescroll({
    navSelector  : "li.pagination",
    nextSelector : "li.pagination a:first",
    itemSelector : "li.rounded",
    loadingText  : '<span class="scroll-txt>loading...</span>"',
    donetext     : ''
  });
});
