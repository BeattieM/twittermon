App.messages = App.cable.subscriptions.create('PostsChannel', {  
  received: function(data) {
    this.renderAction(data);
    if(data.count == 0){
      $("#no-posts").show();  
    } else {
      $("#no-posts").hide();
    }
  },

  renderAction: function(data) {
    switch (data.type) {
      case 'create':
        this.renderCreate(data);
        break;
      case 'update':
        this.renderUpdate(data);
        break;
      case 'delete':
        this.renderDelete(data);
        break;
    }
  },

  renderCreate: function(data) {
    $("#post_comment").val('');
    $("#post_comment").removeClass('has-text');
    $("#submit-post").prop("disabled",true);
    $("#submit-post").hide();
    $('#posts').prepend(this.renderPost(data));
  },

  renderPost: function(data) {
    var uuid = data.post.uuid;
    var post = `
      <div class='post' id='`+uuid+`'>
        <div class='post-pokemon'>
          <img src='`+data.sprite+`'>
        </div>
        <div class='post-content'>
          <p class='date'>
            `+moment(data.post.created_at).format('D MMM YYYY');
    if($("#current_user").attr('class') == data.post.user_id){
      post += `<span class='controls'>
                  <button class="astext edit-post" value='`+uuid+`'>edit</button> - <button class="astext delete-post" value='`+uuid+`'>delete</button>
                <span>`
    }
    post += `</p>
              <p id='post_`+uuid+`_comment'>`+data.post.comment+`</p>
            </div>
          </div>`;
    return post;
  },

  renderUpdate: function(data) {
    $("#post_"+data.post.uuid+"_comment").html(data.post.comment);
    $('#editModal').modal('hide');
  },

  renderDelete: function(data) {
    $("#"+data.post.uuid).remove();
    $('#deleteModal').modal('hide');
  }
});