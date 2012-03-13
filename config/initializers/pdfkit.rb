PDFKit.configure do |config|
  if Rails.env.development?
    config.wkhtmltopdf = '/usr/bin/wkhtmltopdf'
  else
    config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'   
  end
end
