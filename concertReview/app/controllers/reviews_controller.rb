class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  helper_method :recentReviews

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  def recentReviews
    @recentReviews = Review.last(10).reverse
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create

    date_string = "#{review_params['date(1i)']}-#{review_params['date(2i)']}-#{review_params['date(3i)']}"
    #review_params[:artist].capitalize!
    #review_params[:venue].capitalize!
    artist_string = review_params[:artist].titleize
    venue_string = review_params[:venue].titleize
    #only works for creating the concert/artist, review still has lowercase

    @review = Review.create(review_params)

    if @review.save
      @artist = Artist.find_or_create_by(name: artist_string)
      @concert = Concert.find_or_create_by(artist: @artist, venue: venue_string, date: date_string)
      @review.concert_id = @concert.id
      @review.user_id = session[:user_id]
      @review.save
    end

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render action: 'show', status: :created, location: @review }
      else
        format.html { render action: 'new' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:artist, :venue, :date, :genre, :sound, :stagePresence, :songSelection, :overallRating, :comments)
    end
end
