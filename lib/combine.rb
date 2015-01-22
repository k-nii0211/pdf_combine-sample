require 'prawn'
require 'combine_pdf'
require 'tempfile'

file = "#{File.dirname(__FILE__)}/../reports/hoge.pdf"

temp = Tempfile.new('temp.pdf')
temp_path = temp.path

Prawn::Document.generate(temp_path, size: 'A4') do
  text_box 'fugaaaaa', at: [0, 700]
end

stamp = CombinePDF.new(temp_path).pages[0]

pdf = CombinePDF.new(file)

pdf.pages.each do |page|
  page << stamp
end

pdf.save "#{File.dirname(__FILE__)}/../reports/combine.pdf"

temp.unlink
