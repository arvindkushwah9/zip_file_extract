class Document < ApplicationRecord
	mount_uploader :name, FileUploader
end
