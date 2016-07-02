jQuery(document).ready(function(){
  $('.btn-create-comment').click(function(){
    $(this).closest('#comments-index-container').find('.comments-comment-form-container').fadeIn()
    $('html,body').animate({ scrollTop: $('.comments-comment-form-container').offset().top - 30 }, 'slow');
  })

  $('.actions .btn-reply').click(function(){
    $('.information .reply-form').hide()
    $(this).closest('.information').find('> .reply-form').fadeIn()
  })
})