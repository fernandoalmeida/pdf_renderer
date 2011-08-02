module PdfRenderer
  require 'action_controller'
  require 'pdfkit'
  
  Mime::Type.register 'application/pdf', :pdf
  
  ActionController::Renderers.add :pdf do |filename, options|
    layout   = options[:layout] || "application.html.erb"
    template = "/#{controller_name}/#{action_name}.html.erb"
    html     = render_to_string(:layout => layout, :template => template)
    kit      = PDFKit.new(html, DEFAULT_OPTIONS)
    send_data(kit.to_pdf, :filename => "#{filename || request.path.gsub('/','_')}.pdf", :type => 'application/pdf', :disposition => 'attachment')
  end

  DEFAULT_OPTIONS = {
    :page_size          => 'A4',
    :print_media_type   => true,
    :margin_left        => 4,
    :margin_right       => 2,
    :margin_top         => 2,
    :margin_bottom      => 2
  }

end
