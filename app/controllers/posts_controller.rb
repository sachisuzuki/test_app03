class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit edit_divesite update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    @locations = Location.includes(:divesites)
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
    @areas = Location.pluck(:area).uniq

  end

  # def select_zone
  #   respond_to do |format|
  #     if params[:area]
  #       @zones = Location.where(area: params[:area]).pluck(:zone).uniq
  #       format.js { render :select_zone }
  #
  #     else
  #       format.html { redirect_to new_post_url, notice: '海況を投稿する地域を選択してください' }
  #     end
  #   end
  # end
  #
  # def select_divesite
  #   respond_to do |format|
  #     if params[:zone]
  #       locations = Location.where(zone: params[:zone]).pluck(:id)
  #       @divesites = Divesite.where(location_id: locations).pluck(:name)
  #       format.js { render :select_divesite }
  #     else
  #       format.html { redirect_to new_post_url, notice: '海況を投稿するエリアを選択してください' }
  #     end
  #   end
  # end
  #
  # def set_divesite
  #   respond_to do |format|
  #     if params[:divesite]
  #       @post = current_user.posts.new
  #       @divesite = Divesite.find_by(name: params[:divesite])
  #       format.js { render :set_divesite }
  #     else
  #       format.html { redirect_to new_post_url, notice: '海況を投稿するダイブサイトを選択してください' }
  #     end
  #   end
  # end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /posts/1/edit
  def edit
    @locations = Location.all
    @divesites = Divesite.includes(:location)
  end

  # def edit_divesite
  #   respond_to do |format|
  #     if params[:divesite]
  #       @divesite = Divesite.find_by(name: params[:divesite])
  #       format.js { render :edit_divesite }
  #     else
  #       format.html { redirect_to edit_post_url, notice: '海況を投稿するダイブサイトを選択してください' }
  #     end
  #   end
  # end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:divepoint, :status, :temp, :visibility, :content, :image, :video, :divesite_id,)
  end
end
