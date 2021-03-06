class BillsController < ApplicationController
  before_action :authenticate_user!
  def new
    @invoice = Invoice.find(params[:invoice_id])
    @bill = @invoice.bills.build
  end

  def create
    invoice = Invoice.find(params[:invoice_id])
    bill = invoice.bills.build(bill_params)

    if bill.save
      redirect_to invoices_path, notice: "Factura agregada con éxito"
    else
      flash[:errors] = "No se pudo adjuntar la factura"
      render :new
    end
  end

  def bill_params
    params.require(:bill).permit(:code, :invoice_doc)
  end
end
