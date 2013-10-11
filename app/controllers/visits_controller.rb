class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :edit, :update, :destroy]

  # Removes old visits
  def prune
    # TODO: Can we do this with some kind of ... WHERE clause query?
    # User.where(:age => 15).destroy_all
    # Visit.where("created_at < ?", now)
    # Client.where("created_at >= :start_date AND created_at <= :end_date", {:start_date => params[:start_date], :end_date => params[:end_date]})
    visits = Visit.all
    now = Time.new
    one_day_ago = now - (24*60*60) # TODO: Make this a config parameter
    visits.each do |visit|
      if visit.created_at < one_day_ago
        visit.destroy
      end
    end
  end

  # GET /visits
  # GET /visits.json
  def index
    prune
    @visits = Visit.all
  end

  # GET /visits/1
  # GET /visits/1.json
  def show
  end

  # GET /visits/new
  def new
    @visit = Visit.new
  end

  # GET /visits/1/edit
  def edit
  end

  # POST /visits
  # POST /visits.json
  def create
    prune
    @visit = Visit.new(visit_params)

    respond_to do |format|
      if @visit.save
        format.html { redirect_to @visit, notice: 'Visit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @visit }
      else
        format.html { render action: 'new' }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visits/1
  # PATCH/PUT /visits/1.json
  def update
    respond_to do |format|
      if @visit.update(visit_params)
        format.html { redirect_to @visit, notice: 'Visit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visits/1
  # DELETE /visits/1.json
  def destroy
    @visit.destroy
    respond_to do |format|
      format.html { redirect_to visits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visit_params
      params.require(:visit).permit(:useragent, :latitude, :longitude)
    end
end
