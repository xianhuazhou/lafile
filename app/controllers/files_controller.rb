class FilesController < ApplicationController
  before_filter :init_paths
  FILES_ROOT_DIR = '/'

  def init_paths
    @current_path = current_path 
    @full_path = File.join FILES_ROOT_DIR, @current_path 
  end

  def index
    if is_file?(@full_path) 
      return send_file(@full_path, :type => type_of(@full_path))
    else
      @files = Files::Files.new(@full_path)
    end
    session[:paths_history] = [] unless session[:paths_history]
    session[:paths_history] << @current_path 

    @paths_history = {'History' => ''}
    session[:paths_history].each do |it|
      @paths_history[it] = it unless it.blank?
    end
  end

  def upload
    file = params[:file]
    file_path = File.join(CGI.unescape(@full_path), file.original_filename)
    FileUtils.cp file.path, file_path 
    redirect_to :action => :index, :current_path => params[:current_path]
  end

  def list_files
    @files = Dir["#{params[:term]}*"]
    render :layout => false
  end

  private

  def is_file?(file_path)
    File.exists?(file_path) && !File.directory?(file_path)
  end

  def current_path
    strip_field(params[:path] || params[:current_path])
  end

  def strip_field(field_value)
    field_value.to_s.gsub('..', '').gsub('//', '/').strip
  end

  # get the file's type 
  # from Nginx
  def type_of(file)
    case File.extname(file)
    when /\.(sh|perl|php|rb|js|css|txt|log|info)$/i
      'text/plain'
    when /\.html?$/i
      'text/html' 
    when /\.xml$/i
      'text/xml' 
    when /\.rss$/i
      'application/rss-xml' 
    when /\.atom/i
      'application/atom-xml' 

    when /\.jpe?g$/i
      'image/jpeg'
    when /\.png$/i
      'image/png'
    when /\.gif$/i
      'image/gif'
    when /\.tif$/i
      'image/tiff'

    when /\.pdf$/i
      'application/pdf'
    when /\.docx?/i
      'application/msword'

    when /\.mp[34]$/i
      'audio/mpeg'
    when /\.(mid|midi|kar)$/i
      'audio/midi'
    when /\.ogg$/i
      'audio/ogg'
    when /\.ra$/i
      'audio/x-realaudio'
    when /\.3gpp?$/i
      'audio/3gpp'
    when /\.mov$/i
      'audio/quicktime'
    when /\.flv$/i
      'audio/x-flv'
    when /\.wmv$/i
      'audio/x-ms-wmv'
    when /\.mng/i
      'audio/x-mng'
    when /\.avi$/i
      'audio/x-msvideo'
    when /\.as[xf]$/i
      'audio/x-ms-asf'

    else
      'application/octet-stream'
    end
  end
end
