# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
    def index
      @movies = Movie.all
    end

    def show
        id = params[:id] # retrieve movie ID from URI route
        @movie = Movie.find(id) # look up movie by unique ID
        # will render app/views/movies/show.html.haml by default
    end

    def new
        @movie = Movie.new
        # default: render 'new' template
    end 

    def create
        params.require(:movie)
        permitted = params[:movie].permit(:title,:rating,:release_date)
        @movie = Movie.create!(permitted)
        flash[:notice] = "#{@movie.title} was successfully created."
        # redirect_to movies_path # redirect to the index action after a successful create
        redirect_to action: "show", id: @movie.id # redirect to the show action after a successful create
    end

    def edit
        @movie = Movie.find params[:id]
    end

    def update
        @movie = Movie.find params[:id]
        permitted = params[:movie].permit(:title,:rating,:release_date)
        @movie.update!(permitted)
         
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