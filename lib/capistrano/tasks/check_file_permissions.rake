# frozen_string_literal: true

desc 'Check that cap can access everything'
task :check_file_permissions do
  on roles(:app) do |host|
    if test("[ -w #{fetch(:deploy_to)} ]")
      info "#{fetch(:deploy_to)} is writable on #{host}"
    else
      error "#{fetch(:deploy_to)} is not writable on #{host}"
    end
  end
end