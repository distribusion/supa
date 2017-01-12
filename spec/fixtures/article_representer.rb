module Supa
  class ArticleRepresenter
    include Supa::Representable

    define do
      namespace :jsonapi do
        virtual :version, 1.1, modifier: :to_s
      end

      namespace :meta do
        attribute :locale, :language, exec_context: :representer
      end

      namespace :data do
        attribute :id
        virtual :type, 'articles'

        namespace :attributes do
          attribute :title
          attribute :text
        end

        namespace :relationships do
          object :author do
            namespace :data do
              attribute :id
              virtual :type, 'authors'
            end
          end

          namespace :comments do
            collection :data, :comments do
              attribute :id
              virtual :type, 'comments'
            end
          end
        end
      end

      collection :included, :author do
        attribute :id
        virtual :type, 'authors'

        namespace :attributes do
          attribute :first_name
          attribute :last_name
        end
      end

      append :included, :comments do
        attribute :id
        virtual :type, 'comments'

        namespace :attributes do
          attribute :text
        end
      end
    end

    def to_s(value)
      value.to_s
    end

    def language
      'en'
    end
  end
end
