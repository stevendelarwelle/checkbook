class LedgersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ledger, only: [:show, :edit, :update,:cleared, :destroy]
  
  respond_to :html, :js



  def cleared

    @ledger.update_attributes(cleared: 1)
    respond_to do |format|
      format.html {redirect_to ledgers_path, notice:"Ledger Updated"}
    end
  end

  def addnew
    @ledger=current_user.ledgers.new(ledger_params)
    @ledger.save
    respond_to do |format|
      format.html{redirect_to ledgers_path, notice:"Success"}
    end
  end

  def index
    @ledgers = current_user.ledgers.all.order(id: :desc)
    @ledgerscash=@ledgers.sum('amount')
    @ledgersbank=@ledgers.where("cleared = 't'").sum('amount')
    @ledgersdiff=@ledgers.sum('amount')- @ledgers.where("cleared = 't'").sum('amount')
    respond_with(@ledgers)
  end

  def show
    respond_with(@ledger)
  end

  def new
    @ledger = Ledger.new
   respond_with(@ledger) 
  end

  def edit
  end

  def create
    @ledgers = current_user.ledgers.all.order(id: :desc)
    
    @ledger = current_user.ledgers.new(ledger_params)
    @ledger.save
    
    @ledgerscash=@ledgers.sum('amount')
    @ledgersbank=@ledgers.where("cleared = 't'").sum('amount')
    @ledgersdiff=@ledgers.sum('amount') -@ledgers.where("cleared = 't'").sum('amount') 
    
    
    respond_with(@ledger)
  end

  def update
    
    @ledger.update(ledger_params)
    @ledgers = current_user.ledgers.all.order(id: :desc)
    @ledgerscash=@ledgers.sum('amount')
    @ledgersbank=@ledgers.where("cleared = 't'").sum('amount')
    @ledgersdiff=@ledgers.sum('amount') -@ledgers.where("cleared = 't'").sum('amount') 
    
    
    respond_with(@ledger)
  end

  def destroy
    @ledger.destroy
    respond_with(@ledger)
  end

  private
    def set_ledger
      @ledger = Ledger.find(params[:id])
    end

    def ledger_params
      params.require(:ledger).permit(:user_id,:description, :amount, :cleared)
    end
end
