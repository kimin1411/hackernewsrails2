class CommentsController < ApplicationController

  def index
    redirect_to("/posts/#{params[:post_id]}")
  end

  # GET /posts/1/edit
  def edit
  end


  def show
    redirect_to("/posts/#{params[:post_id]}")
  end

  def create
    # params["comments"]["user_id"] = current_user.id
    @user = User.find(current_user.id)
    @comment = @user.comments.build(post_params)
    @post = Post.find(params[:post_id])
    @post.comments << @comment
    if @comment.save
      redirect_to @post, notice: 'Post was successfully created.'

    else
      render :new

    end

  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html {render :edit}
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to @post, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id])
      @comments = Comment.where(post_id: params[:post_id])
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:comment).permit(:comment)
    end

end
