class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    # @movie = Movie.find(params[:movie_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    # @bookmark.movie = @movie
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(params[:list_id])
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list_id), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
