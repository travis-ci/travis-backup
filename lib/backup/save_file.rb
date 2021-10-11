# frozen_string_literal: true

module SaveFile
  def save_file(file_path, content) # rubocop:disable Metrics/MethodLength
    return true if @config.dry_run

    saved = false
    begin
      ensure_path(file_path)

      File.open(full_file_path(file_path), 'w') do |file|
        file.write(content)
        file.close
        saved = true
      end
    rescue => e
      print "Failed to save #{file_path}, error: #{e.inspect}\n"
    end
    saved
  end

  def ensure_path(file_path)
    path = folder_path(file_path)
      
    unless File.directory?(path)
      FileUtils.mkdir_p(path)
    end  
  end

  def full_file_path(file_path)
    "#{@config.files_location}/#{file_path}"
  end

  def folder_path(file_path)
    result = full_file_path(file_path).split('/')
    result.pop
    result.join('/')
  end
end
