class Document < ApplicationRecord
	mount_uploader :name, FileUploader
	require 'zip'

	def extract_zip_file
		extract_zip(self.file_path, self.destination_path)
	end	
	def extract_zip(file, destination)
		begin	 
		  FileUtils.mkdir_p(destination)
		  Zip::File.open(file) do |zip_file|
		    zip_file.each do |f|
		      fpath = File.join(destination, f.name)
		      zip_file.extract(f, fpath) unless File.exist?(fpath)
		    end
		  end
  	rescue Exception => e 
  		puts e
  	end
	end

	def file_path
		file_path = Rails.root.join("public", "uploads", "document", "name","#{self.id}","#{self.zip_file_name}").to_s
	end
	def destination_path
		destination_path =  Rails.root.join("public", "uploads", "document", "name","#{self.id}").to_s
	end
	def zip_file_name
		self.name.file.filename			
	end
	def extracted_file_name
		extracted_file_name = self.zip_file_name.split(".zip").first	
		if self.zip_file_name.include?(".tar.gz")
			extracted_file_name = self.zip_file_name.split(".tar.gz").first			
		end
		return extracted_file_name	
	end
	def extracted_file_path
    extracted_file_path = Rails.root.join("public", "uploads", "document", "name","#{self.id}","#{self.extracted_file_name}").to_s
  end
end
