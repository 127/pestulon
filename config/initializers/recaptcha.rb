Recaptcha.configure do |config|
  config.site_key  = (Rails.env.development? || Rails.env.test?) ? '6Lf_KSkTAAAAAESqlOzMPjSt25BhgcnRTKU6S0lu' : 'SETUP!'
  config.secret_key = (Rails.env.development? || Rails.env.test?) ? '6Lf_KSkTAAAAANcVUDxHwLv6piL_hN4dlUPIps6q' : 'SETUP!'
end