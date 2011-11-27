# encoding: UTF-8
require File.expand_path File.join(File.dirname(__FILE__), 'helper', 'test_helper.rb')

class FilesTest < Test::Unit::TestCase
  def setup
    @data_dir = File.expand_path(File.dirname(__FILE__) + '/data')
    FileUtils.mkdir(@data_dir) unless File.exists?(@data_dir)

    FileUtils.mkdir(@data_dir + "/a") 
    FileUtils.mkdir(@data_dir + "/b") 
    FileUtils.mkdir(@data_dir + "/c") 
    FileUtils.mkdir(@data_dir + "/b/b1") 
    FileUtils.mkdir(@data_dir + "/b/b2") 
    FileUtils.mkdir(@data_dir + "/c/c1") 

    write_file(@data_dir + "/hello.txt", "hello")
    write_file(@data_dir + "/a/1.txt", "1.txt")
    write_file(@data_dir + "/a/2.txt", "2.txt")
    write_file(@data_dir + "/b/b1/b1a.txt", "b1a.txt")
    write_file(@data_dir + "/b/b1/b1b.txt", "b1b.txt")
    write_file(@data_dir + "/b/b1.txt", "b1.txt")
    write_file(@data_dir + "/c/10.txt", "10.txt")

  end

  def write_file(file, data)
    File.open(file, 'w') do |f|
      f.write data
    end
  end

  def teardown
    FileUtils.rm_rf @data_dir
  end

  def test_list_files
    files = Files::Files.new(@data_dir)
    assert_equal ['hello.txt', 'a', 'b', 'c'].sort, files.list_files

    files = Files::Files.new(@data_dir + "/b")
    assert_equal ['b1', 'b1.txt', 'b2'], files.list_files

    files = Files::Files.new(@data_dir + "/b/b1")
    assert_equal ['b1a.txt', 'b1b.txt'], files.list_files
  end
end
