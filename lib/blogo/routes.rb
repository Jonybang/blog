module Blogo
  module Routes
    def self.mount_to(context, opts)
      blog_scope = opts[:at] || '/blogo'

      context.instance_eval do
        scope(path: blog_scope, module: 'blogo', as: 'blogo') do
          namespace :admin do
            # blogo_admin_path
            get '/' => 'posts#index', as:  ''
            get '/projects' => 'projects#index', as:  :projects
            get 'logout' => 'sessions#destroy'
            get 'login' => 'sessions#new', as: 'login'

            post  '/posts/preview' => 'posts#preview', as: :post_preview
            patch '/posts/preview' => 'posts#preview'

            post  '/projects/preview' => 'projects#preview', as: :project_preview
            patch '/projects/preview' => 'projects#preview'

            resources :sessions,  only: %w(new create destroy)
            resources :posts,     except: %w(show)
            resources :projects,  except: %w(show)
            resources :users
            resources 'comments', only: %w(index)
            resources 'images'  , only: %w(create)
          end

          get '/'                    => 'posts#index', as: 'root'
          get '/projects'            => 'projects#index', as: 'projects'
          get '/page/:page'          => 'posts#index', as: 'page'
          get '/projects/:page'      => 'projects#show', as: 'project'
          get '/tag/:tag'            => 'posts#index', as: 'tag'
          get '/tag/:tag/page/:page' => 'posts#index', as: 'tag_page'
          get '/feed'                => 'posts#feed' , as: 'feed', defaults: { format: 'atom' }
          get ':permalink'           => 'posts#show' , as: 'post'
        end
      end
    end
  end
end
