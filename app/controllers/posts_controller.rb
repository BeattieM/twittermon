# Controller for Post specific endpoints
class PostsController < ApplicationController
  def index
    @posts = Post.all.order(id: :desc)
    @post = Post.new
  end

  def create
    post = Post.new(comment: post_params[:comment], user: current_user, pokemon: PokemonService.search_for_pokemon)
    return unless post.save
    broadcast(post, 'create')
    head :ok
  end

  def update
    post = current_user.posts.find_by_uuid(params[:id])
    if post
      post.update_attributes(post_params)
      broadcast(post, 'update')
      head :ok
    else
      head 404
    end
  end

  def destroy
    post = current_user.posts.find_by_uuid(params[:id])
    if post
      post.destroy
      broadcast(post, 'delete')
      head :ok
    else
      head 404
    end
  end

  private

  def post_params
    params.require(:post).permit(:comment)
  end

  def broadcast(post, type)
    ActionCable.server.broadcast 'posts',
                                 count: Post.count,
                                 post: post,
                                 sprite: post.sprite,
                                 type: type
  end
end
