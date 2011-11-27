module FilesHelper
  def is_root_path(path)
    path == '/' or path == ''
  end

  def current_path_name(path)
    is_root_path(path) ? '/ROOT' : path
  end

  def show_file_icon(filename)
    img =  if File.directory? filename
             'directory.jpg'
           else
             case File.extname(filename)
             when /\.(jpe?g|gif|png|tif)/i
               'image.jpg'
             when /\.(doc|docx)/i
               'word.jpg'
             when /\.pdf/i
               'pdf.jpg'
             when /\.(html|css|js)/i
               'html.jpg'
             when /\.(xml|xslt)/i
               'xml.jpg'
             when /\.(zip|rar|gz|bz2)/i
               'zip.jpg'
             when /\.(mp3|wma|rma|ogg)/i
               'music.jpg'
             when /\.(mp4|mov|wmv|rm|rmvb|avi)/i
               'movie.jpg'
             when /\.(exe|bat|vbs)/i
               'exe.jpg'
             when /\.(iso|img)/i
               'iso.jpg'
             when /\.(pptx?)/i
               'ppt.jpg'
             else
               'file.jpg'
             end
           end
    image_tag("icon/" + img)
  end
end
