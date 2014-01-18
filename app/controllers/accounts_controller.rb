class AccountsController < ApplicationController
  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = current_user.accounts
    @budget_total = current_user.budget_total
    @accounts_total = current_user.accounts_total

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = Account.find(params[:id])
    @account.reload
    @transactions = @account.last_weeks_transactions
    @recurs = @account.recurs
    @split_account = @account.split_account


    if @split_account.nil?
      @split_account_name = "None"
    else
      @split_account_name = @split_account.name
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.json
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(params[:account])
    @account.users << current_user

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render json: @account, status: :created, location: @account }
      else
        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end

    @account.save
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end

  def add
    account = Account.find(params[:id])
    amount = params[:amount].to_i
    subtract = params[:subtract]
    split_account = account.split_account

    amount = amount * -1 if subtract

    if params[:split].present? && !split_account.nil?
      amount = amount/2
      split_amount = amount * -1

      transaction_split = Transaction.create :user => current_user, :account => split_account
      transaction_split.value = split_amount
      transaction_split.execute
    end

    transaction_main = Transaction.new :user => current_user, :account => account
    transaction_main.value = amount
    transaction_main.execute

    redirect_to "/accounts/#{account.id}/"
  end

  def subtract
    @account = Account.find(params[:id])
    @amount = params[:amount].to_i
    @amount -= 2*@amount
    @description = params[:description]
    @description = @account.name if @description.blank?
    
    transaction = @account.new_transaction(@amount, @description)
    transaction.execute

    begin
      UserMailer.transaction_email(current_user, transaction).deliver
    rescue
    end

    redirect_to "/accounts/#{@account.id}/"
  end

  # shows all accounts. only for admins
  def index_all
    @accounts = Account.all
  end

end
