# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Code Sample

require 'zip'

def extract_zip(file, destination)
  FileUtils.mkdir_p(destination)

  Zip::File.open(file) do |zip_file|
    zip_file.each do |f|
      fpath = File.join(destination, f.name)
      zip_file.extract(f, fpath) unless File.exist?(fpath)
    end
  end
end

file_path = Rails.root.join('public', 'uploads', 'document', 'name','2','upload_zip.zip').to_s
destination_path =  Rails.root.join('public', 'uploads', 'document', 'name','2').to_s

extract_zip(file_path, destination_path)