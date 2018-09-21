desc 'Copies some linked files to the remote server.'
task :linked_files do
  on roles(:all) do |host|
    info "Uploading files to #{host}"
    execute :mkdir, '-p', "#{fetch(:deploy_to)}/shared/config"
    within "#{fetch(:deploy_to)}/shared/config" do
      upload! 'config/database.yml', 'database.yml'
    end
  end
end