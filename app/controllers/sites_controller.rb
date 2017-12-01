class SitesController < ApplicationController
  # GET /customers/:customer_id/sites
  # GET /customers/:customer_id/sites.xml
  def index
    @sites = Site.all
  end

  # GET /customers/:customer_id/sites/:id
  # GET /sites/:id.xml
  def show
    #customer = Customer.find(params[:customer_id])
    @site = Site.find_by(id: params[:id])
    if @site.nil?
      redirect_to action: :index
    end
  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @site }
    end
  end

  # GET /customers/:customer_id/sites/new
  # GET /customers/:customer_id/sites/new.xml
  def new
    #1st you retrieve the customer thanks to params[:customer_id]
    customer = Customer.find(params[:customer_id])
    #2nd you build a new one
    @site = customer.sites.create

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @site }
    end
  end

  # GET /customers/:customer_id/sites/:id/edit
  def edit
    @site = Site.find(params[:id])
  end

  # POST /customers/:customer_id/sites
  # POST /customers/:customer_id/sites.xml
  def create
    #1st you retrieve the customer thanks to params[:customer_id]
    customer = Customer.find(params[:customer_id])
    #2nd you create the site with arguments in params[:site]
    @site = customer.sites.create(params[:site_id])


    respond_to do |format|
      if @site.save
        #1st argument of redirect_to is an array, in order to build the correct route to the nested resource site
        format.html { redirect_to([@site.customer, @site], :notice => 'Site was successfully created.') }
        #the key :location is associated to an array in order to build the correct route to the nested resource site
        format.xml  { render :xml => @site, :status => :created, :location => [@site.customer, @site] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /customers/:customer_id/sites/:id
  # PUT /customers/:customer_id/sites/:id.xml
  def update
    #retrieve the site thanks to params[:id]
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update(site_params)
        #1st argument of redirect_to is an array, in order to build the correct route to the nested resource site
        format.html { redirect_to([@site.customer, @site], :notice => 'Site was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/:customer_id/sites/1
  # DELETE /customers/:customer_id/sites/1.xml
  def destroy
    # retrieve the site thanks to params[:id]
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
   private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = @customer.find(params[:id]).sites
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:name, :address, :contact, :phone, :email, :customer_id, customers_attributes: [:name, :id])
    end
    
    def set_customer
      @customer = Customer.find(params[:customer_id])
    end
end