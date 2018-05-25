class PostsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
      @post = current_user.posts.build(post_params)
      
      
      if @post.save
        flash[:success] = 'コメントを投稿しました。'
      else
        flash[:danger] = 'コメントの投稿に失敗しました。'
      end
      redirect_to group_path(@post.group)
  end

  def destroy
  end
  
    private

  def post_params
    params.require(:post).permit([:content, :user_id, :group_id, :created_at])
  end
  
end
