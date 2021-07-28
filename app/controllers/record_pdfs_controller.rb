class RecordPdfsController < ApplicationController
  def index
    @record = Item.find_by_id(params[:id]) if params[:id]

    if @record === nil
      redirect_back(fallback_location: root_path)
    else
    respond_to do |format|
      format.html
      format.pdf do

        # pdfを新規作成。インスタンスを渡す。
        pdf = RecordPdf.new(@record)

        send_data pdf.render,
          filename:    "sample.pdf",
          type:        "application/pdf",
          disposition: "inline" # 画面に表示。外すとダウンロードされる。
        end
     end
    end
  end
end