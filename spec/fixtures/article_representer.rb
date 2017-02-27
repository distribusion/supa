module Supa
  class ArticleRepresenter
    include Supa::Representable

    define do
      namespace :jsonapi do
        virtual :version, getter: 1.1, modifier: :to_s
      end

      namespace :meta do
        attribute :locale, getter: :language, exec_context: :representer
        attribute :date, exec_context: :representer
      end

      object :data, getter: :itself do
        attribute :id
        virtual :type, getter: 'articles'

        namespace :attributes do
          attributes [:title, :text]
        end

        namespace :relationships do
          object :author do
            namespace :data do
              attribute :id
              virtual :type, getter: 'authors'
            end
          end

          namespace :comments do
            collection :data, getter: :comments do
              attribute :id
              virtual :type, getter: 'comments'
            end
          end
        end
      end

      collection :included, getter: :author, modifier: :to_a, empty_when_nil: true, hide_when_empty: true do
        attribute :id
        virtual :type, getter: 'authors'

        namespace :attributes do
          attribute :first_name
          attribute :last_name
        end
      end

      append :included, getter: :comments, empty_when_nil: true, hide_when_empty: true do
        attribute :id
        virtual :type, getter: 'comments'

        namespace :attributes do
          attribute :text
        end
      end
    end

    def to_s(value)
      value.to_s
    end

    def to_a(value)
      Array(value)
    end

    def language
      'en'
    end

    def date
      Date.today.iso8601
    end
  end
end
