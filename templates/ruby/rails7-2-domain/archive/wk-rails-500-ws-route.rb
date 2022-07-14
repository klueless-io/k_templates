# frozen_string_literal: true

      resources :{{snake entity.name_plural}} do
        collection do
          get 'multi'
          get 'sample'
        end
      end