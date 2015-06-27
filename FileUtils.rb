class FileUtils 
     
def list_files(folder_name)
	file_list = []
	Dir.new(folder_name).each do |archivo|
		file_list << archivo
	end
	
	return file_list
end

def read_file(file_name)
	content = ""
	File.open(file_name, "r") do |f|
		while linea = f.gets
			content += linea
		end
	end

	return content
end

end