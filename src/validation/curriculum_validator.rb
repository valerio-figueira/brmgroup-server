# validation/curriculum_validator.rb
# frozen_string_literal: true

require 'fileutils'
require 'mime/types'
require_relative '../helpers/recaptcha_verifier'

# Class responsible for validation of body request
class CurriculumValidator
  ALLOWED_EXTENSIONS = ['.jpg', '.jpeg', '.png', '.gif', '.pdf'].freeze
  NAME_REGEX = /^[a-zA-ZÀ-ÖØ-öø-ÿ\s']+$/u.freeze
  EMAIL_REGEX = /^[a-zA-Z0-9._-]{4,}@[a-zA-Z0-9.-]{2,}\.{1}[a-zA-Z]{2,}$/.freeze
  MESSAGE_REGEX = /^[\s\S]{5,500}$/.freeze

  def initialize(params)
    @params = params
  end

  def validate
    validate_recaptcha
    validate_name
    validate_email
    validate_message
    validate_file
  end

  private

  def validate_recaptcha
    recaptcha_secret_key = '#'
    verifier = RecaptchaVerifier.new(recaptcha_secret_key)
    result = verifier.verify_recaptcha(@params['g-recaptcha-response'])
    handle_recaptcha_result(result)
  end

  def handle_recaptcha_result(result)
    puts result[:score]
    puts result[:success]
    raise ArgumentError, 'Você é humano?' unless result[:success]
  end

  def validate_name
    name = @params['name']
    raise ArgumentError, 'Digite seu nome' if name.nil? || name.empty?
    raise ArgumentError, 'Verifique seu nome' unless name.is_a?(String)
    raise ArgumentError, 'Verifique seu nome' unless name.match?(NAME_REGEX)
    raise ArgumentError, 'Digite um nome válido' if name.length < 10
    raise ArgumentError, 'Digite uma mensagem válida' if name.length > 40
  end

  def validate_email
    email = @params['email']
    raise ArgumentError, 'Digite seu e-mail' if email.nil? || email.empty?
    raise ArgumentError, 'Verifique seu e-mail' unless email.is_a?(String)
    raise ArgumentError, 'Verifique seu e-mail' unless email.match?(EMAIL_REGEX)
    raise ArgumentError, 'Digite um e-mail válido' if email.length < 10
    raise ArgumentError, 'Digite uma mensagem válida' if email.length > 40
  end

  def validate_message
    message = @params['message']
    raise ArgumentError, 'Digite sua mensagem' if message.nil? || message.empty?
    raise ArgumentError, 'Verifique sua mensagem' unless message.is_a?(String)
    raise ArgumentError, 'Verifique seu e-mail' unless message.match?(MESSAGE_REGEX)
    raise ArgumentError, 'Digite uma mensagem válida' if message.length < 10
    raise ArgumentError, 'Digite uma mensagem válida' if message.length > 40
  end

  def validate_file
    file = @params[:file]
    raise ArgumentError, 'Arquivo não fornecido' if file.nil?
    raise ArgumentError, 'Arquivo não fornecido' if file[:tempfile].nil?
    raise ArgumentError, 'Arquivo vazio' if file[:tempfile].size.zero?

    filename = file[:filename]
    extension = File.extname(filename).downcase

    raise ArgumentError, 'Formato do arquivo é inválido' unless allowed_file?(extension, file[:tempfile])
  end

  def allowed_file?(extension, file)
    ALLOWED_EXTENSIONS.include?(extension) && allowed_mime_type?(file)
  end

  def allowed_mime_type?(file)
    allowed_mime_types = ['image/jpeg', 'image/png', 'image/gif', 'application/pdf']
    file_mime_type = MIME::Types.type_for(file.path).first

    allowed_mime_types.include?(file_mime_type.to_s)
  end
end
