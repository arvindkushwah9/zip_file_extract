module ApplicationHelper
	def doc_file_name(_attr = {})
		@file_url = _attr[:file_url]
		@file_url.split("/public/uploads/document/name/#{@document.id}/").last
	end
	def doc_file_path(_attr = {})
		@file_url = _attr[:file_url]
		"/uploads/document/name/#{@document.id}/" + doc_file_name({file_url: @file_url})
	end
end
