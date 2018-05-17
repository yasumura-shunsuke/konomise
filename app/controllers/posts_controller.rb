class PostsController < ApplicationController
  def create
      @post = current_user.posts.build(post_params)
      @post.save
      flash[:success] = 'コメントを投稿しました。'
      
      redirect_to group_path(@post.group)
  end

  def destroy
  end
  
    private

  def post_params
    params.require(:post).permit([:content, :user_id, :group_id, :created_at])
  end
  
end
