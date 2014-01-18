class DebtorsController < ApplicationController
  # GET /debtors
  # GET /debtors.json
  def index
    @debtors = Debtor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @debtors }
    end
  end

  # GET /debtors/1
  # GET /debtors/1.json
  def show
    @debtor = Debtor.find(params[:id])
    @accounts = @debtor.accounts

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @debtor }
    end
  end

  # GET /debtors/new
  # GET /debtors/new.json
  def new
    @debtor = Debtor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @debtor }
    end
  end

  # GET /debtors/1/edit
  def edit
    @debtor = Debtor.find(params[:id])
  end

  # POST /debtors
  # POST /debtors.json
  def create
    @debtor = Debtor.new(params[:debtor])
    @account = Account.new
    @account.debtor = @debtor
    @account.cash = 0
    @account.save

    respond_to do |format|
      if @debtor.save
        format.html { redirect_to @debtor, notice: 'Debtor was successfully created.' }
        format.json { render json: @debtor, status: :created, location: @debtor }
      else
        format.html { render action: "new" }
        format.json { render json: @debtor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /debtors/1
  # PUT /debtors/1.json
  def update
    @debtor = Debtor.find(params[:id])

    respond_to do |format|
      if @debtor.update_attributes(params[:debtor])
        format.html { redirect_to @debtor, notice: 'Debtor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @debtor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debtors/1
  # DELETE /debtors/1.json
  def destroy
    @debtor = Debtor.find(params[:id])
    @debtor.destroy

    respond_to do |format|
      format.html { redirect_to debtors_url }
      format.json { head :no_content }
    end
  end

end
