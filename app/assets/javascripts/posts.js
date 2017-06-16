$( document ).ready(function() {
  // Interactions for creating new Post 
  $("#post_comment").focus(function() {
    $("#submit-post").show();
  });

  $("#post_comment").blur(function() {
    if($(this).val()){
      $(this).addClass('has-text');
    } else {
      $(this).removeClass('has-text');
      $("#submit-post").hide();
    }
  });

  $("#post_comment").keyup(function(){
    if($(this).val()){
      $("#submit-post").prop("disabled",false);
    } else {
      $("#submit-post").prop("disabled",true);
    }
  });

  // Interactions for editing a Post 
  $('body').on('click', '.edit-post', function() {
    var post_uuid = $(this).attr("value");
    $('#edit-post-modal').val($("#post_"+post_uuid+"_comment").html());
    $('#post-id').val(post_uuid);
    $("#update-post").prop("disabled",false);
    $('#editModal').modal('show');
  });

  $('#edit-post-modal').keyup(function(){
    if($(this).val()){
      $("#update-post").prop("disabled",false);
    } else {
      $("#update-post").prop("disabled",true);
    }
  });

  $("#edit-form").submit(function(e) {
    $("#update-post").prop("disabled",true);

    $.ajax({
      method: "PATCH",
      url: "/posts/"+$('#post-id').val(),
      dataType: 'JSON',
      data: {post: {comment: $("#edit-post-modal").val()}}
    });
    e.preventDefault();
  });

  // Interactions for deleting a Post 
  $('body').on('click', '.delete-post', function() {
    $('#post-id').val($(this).attr("value"));
    $('#deleteModal').modal('show');
  });

  $("#delete-form").submit(function(e) {
    $.ajax({
      method: "DELETE",
      url: "/posts/"+$('#post-id').val()
    });
    e.preventDefault();
  });
});