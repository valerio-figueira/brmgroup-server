# services/curriculum_servicer.rb
# frozen_string_literal: true

require 'fileutils'
require 'mime/types'
require_relative '../helpers/contact_form_submission'

# Class responsible for handling curriculum file upload.
class CurriculumService
  ALLOWED_EXTENSIONS = ['.jpg', '.jpeg', '.png', '.gif', '.pdf'].freeze

  def handle_upload(params)
    file = create_file_hash(params)
    path = create_paths(params)

    # Create the email subdirectory if it doesn't exist
    Dir.mkdir(path[:folder]) unless Dir.exist?(path[:folder])

    save_path = File.join(path[:folder], file[:name])
    File.open(save_path, 'wb') { |f| f.write(file[:tempfile].read) }

    # Try to send a message to warn about the curriculum
    return { error: 'Falha ao enviar mensagem, tente novamente' } unless send_message?(params, path[:file])

    { message: 'Seu currículo foi enviado com sucesso!' }
  end

  def create_paths(params)
    curriculum_path = File.expand_path("../../curriculum", __dir__)
    folder_path = File.join(curriculum_path, params[:email])
    file_path = File.join(folder_path, params[:file][:filename])

    { folder: folder_path, file: file_path }
  end

  def create_file_hash(params)
    tempfile = params[:file][:tempfile]
    filename = params[:file][:filename]

    { tempfile: tempfile, name: filename }
  end

  def send_message?(params, file_path)
    contact_form = ContactFormSubmission.new(params, file_path)
    contact_form.send_email
  end
end
