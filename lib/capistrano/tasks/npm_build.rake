namespace :npm do
  task :install do
    on roles fetch(:npm_roles) do
      within fetch(:npm_target_path, release_path) do
        with fetch(:npm_env_variables, {}) do
          execute :npm, 'install', fetch(:npm_flags)
          # execute "sh -c \"cd #{fetch(:deploy_to)}/current/ && #{fetch(:build_command)}\""
        end
      end
    end
  end

  before 'deploy:updated', 'npm:install'

  task :prune do
    on roles fetch(:npm_roles) do
      within fetch(:npm_target_path, release_path) do
        execute :npm, 'prune', fetch(:npm_prune_flags)
      end
    end
  end

  task :rebuild do
    on roles fetch(:npm_roles) do
      within fetch(:npm_target_path, release_path) do
        with fetch(:npm_env_variables, {}) do
          execute :npm, 'rebuild'
        end
      end
    end
  end
end

namespace :load do
  task :defaults do
    set :npm_flags, %w(--production --silent --no-progress)
    set :npm_prune_flags, '--production'
    set :npm_roles, :all
  end
end
