class RecursController < ApplicationController
  # GET /recurs
  # GET /recurs.json
  def index
    @recurs = Recur.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @recurs }
    end
  end

  # GET /recurs/1
  # GET /recurs/1.json
  def show
    @recur = Recur.find(params[:id])
    @transactions = @recur.transactions

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @recur }
    end
  end

  # GET /recurs/new
  # GET /recurs/new.json
  def new
    @recur = Recur.new
    @accounts = current_user.accounts

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @recur }
    end
  end

  # GET /recurs/1/edit
  def edit
    @recur = Recur.find(params[:id])
  end

  # POST /recurs
  # POST /recurs.json
  def create
    @recur = Recur.new(params[:recur])
    @recur.user = current_user

    respond_to do |format|
      if @recur.save
        format.html { redirect_to @recur, notice: 'Recur was successfully created.' }
        format.json { render json: @recur, status: :created, location: @recur }
      else
        format.html { render action: "new" }
        format.json { render json: @recur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /recurs/1
  # PUT /recurs/1.json
  def update
    @recur = Recur.find(params[:id])

    respond_to do |format|
      if @recur.update_attributes(params[:recur])
        format.html { redirect_to @recur, notice: 'Recur was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @recur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recurs/1
  # DELETE /recurs/1.json
  def destroy
    @recur = Recur.find(params[:id])
    @recur.destroy

    respond_to do |format|
      format.html { redirect_to recurs_url }
      format.json { head :no_content }
    end
  end
end
