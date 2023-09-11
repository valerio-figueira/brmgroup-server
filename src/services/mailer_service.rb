# services/mailer_service.rb
# frozen_string_literal: true

require_relative '../helpers/recaptcha_verifier'
require_relative '../helpers/contact_form_submission'

# Class responsible to handle messages for contact
class MailerService
  def handle_contact_request(params)
    handle_submission(params)
  end

  def handle_submission(data)
    contact_form = ContactFormSubmission.new(data, nil)

    if contact_form.send_email
      { message: 'Mensagem enviada!' }
    else
      { error: 'Não foi possível enviar a mensagem' }
    end
  end
end
