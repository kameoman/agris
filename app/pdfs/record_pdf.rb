class RecordPdf < Prawn::Document


def initialize(record)


  super(
    page_size: 'A4',
    top_margin: 40,
    bottom_margin: 30,
    left_margin: 20,
    right_margin: 20
  )

  font 'app/assets/fonts/Corporate-Mincho-ver2.ttf'

  @record = record

    stroke_axis # メモリ表示

    # header
    move_down 50
    # contents
    create_title
    create_profile
    create_item
    create_address

end

 def create_title
    table([
      [
        make_cell(content: '出荷伝票', width: 200, align: :left, size: 25),
        # 伝票作成日
        make_cell(content: I18n.l(Date.current, format: :long), width: 200, align: :right, size: 10, valign: :bottom)
      ]
    ], width:400) do
      row(0).borders = []
    end
  end

  def create_profile
    subtable = make_table([
      [
        make_cell(content: '出荷日', width: 70),
        make_cell(content: '年 　　月 　　日', width: 200, align: :center),
        make_cell(content: '規格', width: 50, align: :center),
        make_cell(content: '', width: 80, align: :center)
      ]
    ], width: 400)

    name_box = [
      make_cell(content: '氏名', width: 50),
      make_cell(content: '', width: 350, height: 40, align: :center, valign: :center, size: 20)
    ]

    data = [
      name_box,
      [{ content: subtable, colspan: 2 }]
    ]

    table(data, position: :left, width: 400) do
      row(0).column(0).borders = [:top, :left]
      row(0).column(1).borders = [:right, :top]
      row(0).column(0).borders = [:top, :left]
      row(0).column(1).borders = [:right, :top]
      row(1).column(0).borders = [:top, :left]
      row(1).column(1).borders = [:top, :right]
      row(1).border_lines = [:dashed, :solid, :solid, :solid]
    end
  end
  def create_item
    subtable = make_table([
      [
        make_cell(content: '出荷数量', width: 70),
        make_cell(content: '', width: 200, align: :center),
        make_cell(content: '担当印', width: 50, align: :center),
        make_cell(content: '', width: 80, align: :center)
      ]
    ], width: 400)

    name_box = [
      make_cell(content: '品目', width: 50),
      make_cell(content: '', width: 350, height: 40, align: :center, valign: :center, size: 20)
    ]

    data = [
      name_box,
      [{ content: subtable, colspan: 2 }]
    ]

    table(data, position: :left, width: 400) do
      row(0).column(0).borders = [:top, :left]
      row(0).column(1).borders = [:right, :top]
      row(0).column(0).borders = [:top, :left]
      row(0).column(1).borders = [:right, :top]
      row(1).column(0).borders = [:top, :left]
      row(1).column(1).borders = [:top, :right]
      row(1).border_lines = [:dashed, :solid, :solid, :solid]
    end
  end

  def create_address
    address_kana_box = [
      make_cell(content: '出荷先', width: 50),
      make_cell(content: '', width: 450, align: :center)
    ]

    address_box = [
      make_cell(content: '出荷元', width: 50),
      make_cell(content: '', width: 450, align: :center, size: 15)
    ]

    table([
      address_kana_box,
      address_box
    ], width: 500) do
      row(1).column(0).borders = [:top, :left]
      row(1).column(1).borders = [:right, :top]
      row(1).column(0).borders = [:top, :left, :bottom]
      row(1).column(1).borders = [:top, :right, :bottom]
      row(1).border_lines = [:dashed, :solid, :solid, :solid]
    end
  end
end