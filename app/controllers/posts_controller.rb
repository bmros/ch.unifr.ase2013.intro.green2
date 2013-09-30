class PostsController < ApplicationController
 
 http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
 
 helper_method :sort_column, :sort_direction
 def index
  @posts = Post.order(sort_column + ' ' + sort_direction)
  #@posts = Post.all
  #@posts = Post.order(params[:sort])
 end
  
 def new
  @post = Post.new 
 end
 
 def create
  @post = Post.new(params[:post].permit(:title, :text))
 
  if @post.save
    redirect_to @post
  else
    render 'new'
  end
 end
 
 def show
  @post = Post.find(params[:id])
 end
 

 
 def edit
  @post = Post.find(params[:id])
 end
 
 def update
  @post = Post.find(params[:id])
 
  if @post.update(params[:post].permit(:title, :text))
    redirect_to @post
  else
    render 'edit'
  end
 end
 
 def destroy
  @post = Post.find(params[:id])
  @post.destroy
 
  redirect_to posts_path
 end
 
 


 def sort_direction
  %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
 end

 def sort_column
  Post.column_names.include?(params[:sort]) ? params[:sort] : "title"
 end

 
 private
 def post_params
  params.require(:post).permit(:title, :text)
 end
 
 def sort_column
  params[:sort] || "text"
 end
  
 def sort_direction
  params[:direction] || "asc"
 end 
 
  
end
