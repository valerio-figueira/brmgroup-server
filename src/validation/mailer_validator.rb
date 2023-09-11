# validation/mailer_validator.rb
# frozen_string_literal: true

# Class responsible for validation of body request
class MailerValidator
  NAME_REGEX = /^[a-zA-ZÀ-ÖØ-öø-ÿ\s']+$/u.freeze
  EMAIL_REGEX = /^[a-zA-Z0-9._-]{4,}@[a-zA-Z0-9.-]{2,}\.{1}[a-zA-Z]{2,}$/.freeze
  MESSAGE_REGEX = /^[\s\S]{5,500}$/.freeze
  SUBJECT_MODEL = { 0 => 'consultoriaTec', 1 => 'consultoriaCont', 2 => 'suporteTec' }.freeze

  def initialize(params)
    @params = params
  end

  def validate
    validate_recaptcha
    validate_name
    validate_email
    validate_subject
    validate_message
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

  def validate_subject
    subject = @params['subject']
    raise ArgumentError, 'Nos informe do assunto' if subject.nil? || subject.empty?
    raise ArgumentError, 'Verifique o assunto da mensagem' unless subject.is_a?(String)
    raise ArgumentError, 'Verifique o assunto da mensagem' unless SUBJECT_MODEL.value?(subject)
    raise ArgumentError, 'Nos informe do assunto' if subject.length < 10
    raise ArgumentError, 'Digite uma mensagem válida' if subject.length > 40
  end

  def validate_message
    message = @params['message']
    raise ArgumentError, 'Digite sua mensagem' if message.nil? || message.empty?
    raise ArgumentError, 'Verifique sua mensagem' unless message.is_a?(String)
    raise ArgumentError, 'Verifique seu e-mail' unless message.match?(MESSAGE_REGEX)
    raise ArgumentError, 'Digite uma mensagem válida' if message.length < 10
    raise ArgumentError, 'Digite uma mensagem válida' if message.length > 500
  end
end
