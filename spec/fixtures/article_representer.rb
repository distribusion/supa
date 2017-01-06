module Supa
  class ArticleRepresenter
    include Supa::Representable

    define do
      namespace :jsonapi do
        attribute :version, getter: proc { jsonapi_version }
      end

      namespace :data do
        attribute :id
        attribute :type, getter: :articles_type

        namespace :attributes do
          attribute :title
          attribute :text
        end

        namespace :relationships do
          object :author do
            namespace :data do
              attribute :id
              attribute :type, getter: proc { 'authors' }
            end
          end

          namespace :comments do
            collection :data, getter: :comments do
              attribute :id
              attribute :type, getter: proc { 'comments' }
            end
          end
        end
      end

      collection :included, getter: :author do
        attribute :id
        attribute :type, getter: proc { 'authors' }

        namespace :attributes do
          attribute :first_name
          attribute :last_name
        end
      end

      collection :included, getter: :comments, squash: true do
        attribute :id
        attribute :type, getter: proc { 'comments' }

        namespace :attributes do
          attribute :text
          attribute :maxlength, getter: 200
        end
      end
    end

    def jsonapi_version
      1.1
    end

    def articles_type
      'articles'
    end
  end
end
