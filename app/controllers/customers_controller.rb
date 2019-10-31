class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :set_blacklist, :set_active]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.active
  end

  def blacklist
    @customers = Customer.blacklisted
  end

  def set_blacklist
    @customer.blacklist = true
    respond_to do |format|
      if @customer.save
        format.html { redirect_to :blacklist, notice: 'Customer was successfully blocked.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :index }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_active
    @customer.blacklist = false
    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_path, notice: 'Customer was successfully activated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :blacklist }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  def block_by_phone
    if params[:search]
      @customer = Customer.active.where(phone: params[:search]).first
      respond_to do |format|
        if @customer
          @customer.blacklist = true
          if @customer.save
            format.html { redirect_to :blacklist, notice: 'Customer was successfully blocked.' }
            format.json { render :show, status: :ok, location: @customer }
          else
            format.html { redirect_to :blacklist }
            format.json { render json: @customer.errors, status: :unprocessable_entity }
          end
        else
          format.html { redirect_to :blacklist, notice: 'Customer was not found in active' }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :phone, :description, :blacklist, :search)
    end
end
