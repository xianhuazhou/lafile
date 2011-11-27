# encoding: UTF-8
require 'fileutils'

module Files
  class Files
    def initialize(path)
      @path = path
    end

    def list_files
      files = Dir.entries(@path)
      files.delete_if {|f| f == '.' || f == '..'}
      files.sort
    end
  end
end
