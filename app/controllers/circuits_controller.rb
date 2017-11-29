class CircuitsController < ApplicationController
  before_action :set_circuit, only: [:show, :edit, :update, :destroy]

  # GET /circuits
  # GET /circuits.json
  def index
    @circuits = Circuit.all
  end

  # GET /circuits/1
  # GET /circuits/1.json
  def show
    @circuit = Circuit.find_by(id: params[:id])
    if @circuit.nil?
      redirect_to action: :index
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @circuit }
    end
  end

  # GET /circuits/new
  def new
    #1st you retrieve the customer thanks to params[:customer_id]
    site = Site.find(params[:site])
    #2nd you build a new one
    @circuit = site.circuits.create

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @circuit }
    end
  end

  # GET /circuits/1/edit
  def edit
    @circuit = Circuit.find(params[:id])    
  end

  # POST /circuits
  # POST /circuits.json
#  def create
#    #1st you retrieve the customer thanks to params[:customer_id]
#    site = Site.find(params[:site_id])
#    #2nd you create the site with arguments in params[:site]
#    @circuit = site.circuits.create(params[:circuit_id])
#
#    respond_to do |format|
#      if @circuit.save
#        format.html { redirect_to([@circuit.site, @circuit]), :notice => 'Site was successfully created') }
#        format.xml  { render :xml => @circuit, :status => :created, :location => [@circuit.site, @circuit] }
#      else
#        format.html { render :new }
#        format.json { render :xml => @circuit.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
  # PATCH/PUT /circuits/1
  # PATCH/PUT /circuits/1.json
#  def update
#    @circuit = Circuit.find(params[:id])
#    
#    respond_to do |format|
#      if @circuit.update(circuit_params)
#       format.html { redirect_to ([@circuit.site, @circuit], :notice => 'Site was successfully updated.') }
#        format.json { render :show, status: :ok, location: @circuit }
#      else
#        format.html { render :edit }
#        format.json { render json: @circuit.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /circuits/1
  # DELETE /circuits/1.json
  def destroy
    @circuit = Circuit.find(params[:id])
    @circuit.destroy
    
    respond_to do |format|
      format.html { redirect_to circuits_url, notice: 'Circuit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circuit
      @circuit = @site.find(params[:id]).circuits
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def circuit_params
      params.require(:circuit).permit(:id, :type, :speed, :carrier, :site_id, sites_attributes: [:id, :name])
    end
    
    def set_site
      @site = Site.find(params[:site_id])
    end    
end
