# config/initializers/setup_mail.rb


if ["development", "test", "staging"].include?(Rails.env.to_s)
  ActionMailer::Base.raise_delivery_errors = true

  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "openwolf.org",
    :user_name            => "system@openwolf.org",
    :password             => "Bless777",
    :authentication       => "plain",
    :enable_starttls_auto => true
  }

  require "development_mail_interceptor"
  ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor)

end

if Rails.env == "test"
 ActionMailer::Base.delivery_method = :test
end
