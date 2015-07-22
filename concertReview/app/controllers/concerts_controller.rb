class ConcertsController < ApplicationController
  before_action :set_concert, only: [:show, :edit, :update, :destroy]
  helper_method :popularConcerts
  # GET /concerts
  # GET /concerts.json
  def index
    if params[:sort] == "numReviews"
      if params[:direction] == "asc"
        @concerts = Kaminari.paginate_array(Concert.all.sort_by{|concert| concert.reviews.size}.reverse).page(params[:page]).per(15)
      else
        @concerts = Kaminari.paginate_array(Concert.all.sort_by{|concert| concert.reviews.size}).page(params[:page]).per(15)
      end
    elsif params[:sort] == "artist"
      if params[:direction] == "asc"
        @concerts = Kaminari.paginate_array(Concert.all.sort_by{|concert| concert.artist.name}).page(params[:page]).per(15)
      else 
        @concerts = Kaminari.paginate_array(Concert.all.sort_by{|concert| concert.artist.name}.reverse).page(params[:page]).per(15)
      end
    elsif params[:sort] == "avgRating"
      if params[:direction] == "asc"
        @concerts = Kaminari.paginate_array(Concert.all.sort_by{|concert| concert.averageOverall}.reverse).page(params[:page]).per(15)
      else
        @concerts = Kaminari.paginate_array(Concert.all.sort_by{|concert| concert.averageOverall}).page(params[:page]).per(15)
      end
    elsif params[:sort] == "venue"
      @concerts = Concert.all.order(params[:sort]  + " " + params[:direction]).page(params[:page]).per(15)
    elsif params[:sort] == "date"
      @concerts = Concert.all.order(params[:sort] + " " + params[:direction]).page(params[:page]).per(15) 
    else  
      @concerts = Concert.all.page(params[:page])
    end
  end

  def popularConcerts
    @popularConcerts = Concert.all.sort_by{|concert| concert.reviews.size}.reverse.last(5)
  end

  # GET /concerts/1
  # GET /concerts/1.json
  def show
  end

  # GET /concerts/new
  def new
    @concert = Concert.new
  end

  # GET /concerts/1/edit
  def edit
  end

  # POST /concerts
  # POST /concerts.json
  def create
    @concert = Concert.new(concert_params)

    respond_to do |format|
      if @concert.save
        format.html { redirect_to @concert, notice: 'Concert was successfully created.' }
        format.json { render action: 'show', status: :created, location: @concert }
      else
        format.html { render action: 'new' }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /concerts/1
  # PATCH/PUT /concerts/1.json
  def update
    respond_to do |format|
      if @concert.update(concert_params)
        format.html { redirect_to @concert, notice: 'Concert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /concerts/1
  # DELETE /concerts/1.json
  def destroy
    @concert.destroy
    respond_to do |format|
      format.html { redirect_to concerts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concert
      @concert = Concert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concert_params
      params.require(:concert).permit(:venue, :date)
    end
end
