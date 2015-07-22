class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show, :edit, :update, :destroy]

	def new
    	@artist = Artist.new
 	end
  # GET /artists
  # GET /artists.json
  def index
    if params[:search]
        @artists = Artist.search(params[:search].titleize).order("created_at DESC").page(params[:page])
    elsif params[:sort] == "numConcerts"
        @artists = Kaminari.paginate_array(Artist.all.sort_by{|artist| artist.concerts.size}.reverse).page(params[:page]).per(15)
    elsif params[:sort] == "avgRating"
        @artists = Kaminari.paginate_array(Artist.all.sort_by{|artist| artist.avgOverall}.reverse).page(params[:page]).per(15)
    elsif params[:sort] == "numReviews"
        @artists = Kaminari.paginate_array(Artist.all.sort_by{|artist| artist.numReviews}.reverse).page(params[:page]).per(15)
    else
        @artists = Artist.order(:name).page(params[:page])
    end
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
  end

  # GET /artists/new
  def new
    @artist = Artist.new
  end

  # GET /artists/1/edit
  def edit
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(artist_params)

    respond_to do |format|
      if @artist.save
        format.html { redirect_to @artist, notice: 'Artist was successfully created.' }
        format.json { render action: 'show', status: :created, location: @artist }
      else
        format.html { render action: 'new' }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artists/1
  # PATCH/PUT /artists/1.json
  def update
    respond_to do |format|
      if @artist.update(artist_params)
        format.html { redirect_to @artist, notice: 'Artist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_params
      params.require(:artist).permit(:name)
    end
end
