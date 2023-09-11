# services/helpers/contact_form_submission.rb
# frozen_string_literal: true

require 'mail'

# Class responsible to send messages of request
class ContactFormSubmission
  attr_reader :name, :email, :subject, :message, :attachment_path

  def initialize(body_data, attachment_path)
    @name = body_data['name']
    @email = body_data['email']
    @subject = body_data['subject']
    @message = body_data['message']
    @attachment_path = attachment_path
  end

  def send_email
    mail = create_mail_config
    mail.delivery_method :smtp, create_delivery_config
    mail.deliver!
  end

  def create_delivery_config
    {
      address: '#',
      port: 465,
      domain: 'groupbrm.com.br',
      user_name: '#',
      password: '#',
      authentication: :plain,
      ssl: true,
      tls: true,
      enable_starttls_auto: true
    }
  end

  def create_mail_config
    email_body = create_email_body

    Mail.new do
      from 'jvalerio.teste@groupbrm.com.br'
      to 'jvalerio.teste@groupbrm.com.br'
      subject email_body[:subject]
      body email_body[:body]
      add_file email_body[:attachment] if email_body[:attachment]
    end
  end

  def create_email_body
    subject_text = @subject.to_s
    subject_text = "Nova mensagem de #{@name}" if subject_text.empty?
    file_path = @attachment_path

    body_text = <<~BODY
      Name: #{@name}
      Email: #{@email}
      Message: #{@message}
    BODY

    { subject: subject_text, body: body_text, attachment: file_path }
  end
end
