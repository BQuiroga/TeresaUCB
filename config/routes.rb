Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: 'index#inicio'
  post 'posts/new'=> 'posts#create'
  post 'resultados/busqueda'=>'posts#oferta'
  post 'posts/oferta'=> 'posts#publicar'
  get 'newOffer'=> 'posts#offer'

  get '/inicio'=> 'index#inicio'
  get '/users/profile'=>'users#profile'
  get 'education/edit/:id'=>'educations#edit'
  put 'education/update'=> 'educations#update'
  get 'experience/edit/:id'=>'experiences#edit'
  put 'experience/update'=> 'experiences#update'
  get 'membership/edit/:id'=>'memberships#edit'
  put 'membership/update'=> 'memberships#update'
  get 'knowledge/edit/:id'=>'knowledges#edit'
  put 'knowledge/update'=> 'knowledges#update'
  get 'publication/edit/:id'=>'publications#edit'
  put 'publication/update'=> 'publications#update'
  get 'merit/edit/:id'=>'merits#edit'
  put 'merit/update'=> 'merits#update'
  get 'course/edit/:id'=>'courses#edit'
  put 'course/update'=> 'courses#update'
  get 'language/edit/:id'=>'languages#edit'
  put 'language/update'=> 'languages#update'
  post 'follows/new'=> 'follows#create'
  get  'follows/:id/delete'=> 'follows#dejar'
  get 'referential/edit/:id'=>'referentials#edit'
  put 'referential/update'=> 'referentials#update'
  get '/grupos/:id/miembros'=>'groups#show'
  get '/grupos/mis_grupos'=>'groups#index'
  post 'nuevo/grupo'=> 'groups#create'
  get 'users/dejarAmigos'=>'friendships#notmine'
  get 'users/nuevoAmigo'=>'friendships#friend'
  get '/users/Amigo/:id'=>'friendships#friend'
  get 'grupos/botar/:id'=>'groups#botar'
  get 'users/curriculum/edit' =>'resumes#edit'
  post 'company/update'=>'company_informations#update'
  post 'personal/update' =>'personal_informations#update'
  post 'education/new' => 'educations#create'

  post 'experience/new' => 'experiences#create'
  get 'experience/edit/:id'=>'experiences#edit'
  post 'course/new' => 'courses#create'
  get 'mycurriculum' => 'resumes#show'
  post 'knowledge/new'=>'knowledges#create'
  post 'publication/new'=>'publications#create'
  post 'merit/new'=>'merits#create'
  post 'member/new'=>'memberships#create'
  post 'language/new' => 'languages#create'
  get 'curriculums/:id'=>'resumes#external_show'
  get '/oferta/nueva' => 'posts#offer'
  get 'resultados/busqueda' =>'posts#oferta'
  post '/busqueda/usuarios' => 'users#search'
  get 'grupos/:id/abandonar'=> 'groups#abandonar'
  get 'grupos/todos'=>'groups#all'
  get 'grupos/:id/unirme'=>'groups#unirme'
  get 'mis_notificaciones'=>'notifications#index'
  post 'mis_notificaciones/crear'=>'notifications#create'
  get 'mis_notificaciones/:id'=>'notifications#show'
  get 'mis_notificaciones/read/:id'=>'notifications#read'
  get 'mis_notificaciones/unread/:id'=>'notifications#unread'
  get 'mis_notificaciones/new/:id'=>'notifications#new'
  resources :posts
  resources :educations
  resources :referentials
  resources :follows
  resources :languages
  resources :courses
  resources :memberships
  resources :knowledges
  resources :publications
  resources :merits
  resources :experiences

  resources :groups
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  resources :users do
    post 'search',  :on => :collection
  end
end
