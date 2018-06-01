namespace :environ do

  desc "Sets a new secret key."
  task :secret_key do
    on roles(:app) do
      secret = capture :bundle, :exec, :rake, :secret
      execute :sudo, :echo, "'export SECRET_KEY_BASE=\"#{secret}\"' >> /etc/environment"
    end
  end

end