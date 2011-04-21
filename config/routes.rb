OpenwolfV3::Application.routes.draw do

  resources :feriados

  resources :documentotraslados

  resources :archivos    
 
  resources :idiomas

  resources :main
  resources :importar  
  resources :documentocategorias
  resources :documentoclasificaciones
  resources :sentidosresolucion
  resources :recursosrevision
  resources :seguimientos
  resources :estados
  resources :vias
  resources :municipios
  resources :departamentos
  resource :solicitud_informacion  
  resources :razonestiposresoluciones
  resources :tiposresoluciones
  resources :motivosnegativa
  resources :clasificaciones
  resources :rangosedad
  resources :roles 
  resources :profesiones
  resources :fuentes
  resources :tipomensajes
  resources :seguimientos

  resources :portal, :only => [:index] do
    member do
      get:solicitud
      get :print
      get :documento
      get :print_documento
      get :institucion
    end
    collection do
      get :buscar
      get :exportar
    end
  end

  resources :resoluciones do
    collection do
      get :actualizar_razones
    end
  end
  
  resources :instituciones do
    resources :solicitudes do
      resources :actividades do
        resources :seguimientos        
      end
      resources :resoluciones
      resources :recursosrevision
    end

    resources :mensajes do
      collection do
        get :recibidos
        get :enviados
      end
    end    
  end

  resources :documentos do
    member do
      get :plantilla
      get :archivar
      get :trasladar
    end
  end

  # resources :mensajes, :only => [:destroy]

  # resources :instituciones do |instituciones|
  #   instituciones.resources :actividades
  # end
  
  resources :solicitudes do
    member do
      get :cambiar_estado
      get :actualizar_estado
      put :marcar_entregada
    end
    collection do
      get :actualizar_municipios
    end
    resources :adjuntos do
      member do
        get :download
      end
    end
    resources :notas
    resources :resoluciones
    resources :recursosrevision
  end

  resources :adjuntos do
    member do
      get :download
    end
  end
  
  resources :actividades do
    member do
      put :marcar_como_completada
    end    
    collection do
      get :actualizar_usuarios
    end
  end
  
  devise_for :usuarios, :path_prefix => 'd'

  devise_scope :usuario do
    get "/login" => "devise/sessions#new", :as => "login"
    get "/logout" => "devise/sessions#destroy", :as => "logout"
  end
  
  match 'perfil', :to => "usuarios#perfil", :as => "perfil"

  resources :usuarios
  
  match 'imprimir_solicitud/:id',
  :to => 'solicitudes#print', :as => "imprimir_solicitud"

  match 'buscar', :to => "solicitudes#find", :as => "buscar"

  match 'reportes/solicitudes',
  :to => "reportes#solicitudes", :as =>"reporte_solicitudes"
    
  match 'reportes/solicitudes_csv',
  :to => "reportes#solicitudes_csv",  :as => "reporte_solicitudes_csv"

 
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "portal#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
