# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
    def index
      @movies = Movie.all.sort_by { |name| name.title}
    end

    def show
        id = params[:id] # retrieve movie ID from URI route
        begin
            @movie = Movie.find(id) # look up movie by unique ID
        rescue 
            flash[:notice] = "No movie with the given ID could be found."
            redirect_to movies_path
        end
        # @movie = Movie.find(id) # look up movie by unique ID
        # will render app/views/movies/show.html.haml by default
    end

    def new
        @movie = Movie.new
        # default: render 'new' template
    end 

    def create
        params.require(:movie)
        permitted = params[:movie].permit(:title,:rating,:release_date,:description)
        @movie = Movie.new(permitted)
        if @movie.save
            flash[:notice] = "#{@movie.title} was successfully created."
            # redirect_to movies_path # redirect to the index action after a successful create
            redirect_to action: "show", id: @movie.id # redirect to the show action after a successful create
        else
            render 'new' # note, 'new' template can access @movie's field values!
        end
    end

    def edit
        @movie = Movie.find params[:id]
    end

    def update
        @movie = Movie.find params[:id]
        permitted = params[:movie].permit(:title,:rating,:release_date,:description)
        if @movie.update(params[:movie])
            flash[:notice] = "#{@movie.title} was successfully updated."
            redirect_to movie_path(@movie) # redirect to the show action after a successful create
        else
            render 'edit' # note, 'edit' template can access @movie's field values!
        end
    end

    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = "Movie '#{@movie.title}' deleted."
        redirect_to movies_path
    end
end