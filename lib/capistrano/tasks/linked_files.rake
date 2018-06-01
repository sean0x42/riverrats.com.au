desc 'Copies some linked files to the remote server.'
task :linked_files do
  on roles(:all) do |host|
    info "Uploading files to #{host}"
    within "#{fetch(:deploy_to)}/shared/config" do
      upload! 'config/database.yml', 'database.yml'
      upload! 'config/secrets.yml', 'secrets.yml'
    end
  end
end