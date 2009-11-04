class PostsController < ApplicationController

  before_filter :require_admin, :only => [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.find(:all, :order => :updated_at)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    @response = Response.new
    @response.id = params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(@post) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end


  def respond
    if request.post?
      id = params[:post_id]
      @post = Post.find(id)

      @post.responses.create(params[:response])

      if @post.responses.last.save
        Post.find(id).touch
        flash[:notice] = "response posted!"
        redirect_to :controller => "Posts", :action => "view", :id => @response.post_id
      end
    end
  end

  def index
    @posts = Post.find(:all)
    @post = Post.new(params[:post])
  end

  def login
    if request.post?
      if params[:answer][:lol] == "dapopo"
        session[:admin] = true
        redirect_to :controller => "Posts"
      else
        redirect_to :controller => "Posts"
      end
    end
  end

  def logout
    session[:admin] = false
    redirect_to :controller => "Posts"
  end





  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
