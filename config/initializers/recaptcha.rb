Recaptcha.configure do |config|
  # localhost
  config.site_key   = Rails.env.development? ? '6Lf_KSkTAAAAAESqlOzMPjSt25BhgcnRTKU6S0lu' : 'SETUP!'
  config.secret_key = Rails.env.development? ? '6Lf_KSkTAAAAANcVUDxHwLv6piL_hN4dlUPIps6q' : 'SETUP!'
  # 127.0.0.1
  # config.site_key   = Rails.env.development? ? '6LeXtVoUAAAAALzisggNDQ8IzfLocnicPAsuPmGV' : 'SETUP!'
  # config.secret_key = Rails.env.development? ? '6LeXtVoUAAAAALXE2Ke3spxMShiNegF7XxSjeQAR' : 'SETUP!'
end

# [Optional] Skip Test Env
Recaptcha.configuration.skip_verify_env.delete 'test'