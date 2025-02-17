class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    @selected = params[:sort] || session[:sort]
    session[:sort] = @selected
    @ratings = params[:ratings] || session[:ratings]
    @tag = @all_ratings
    @movies = Movie.order(@selected) 
    if @ratings != nil
      @movies = Movie.filter(@ratings.keys)
      @movies = @movies.order(@selected)
      @tag = @ratings.keys
      session[:ratings] = @ratings
    end
    if params[:ratings] != session[:ratings]
      redirect_to :sort => @selected, :ratings => @ratings and return
    elsif params[:sort] != session[:sort]
      redirect_to :sort => @selected, :ratings => @ratings and return
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
