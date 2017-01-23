module Supa
  class ArticlesRepresenter
    include Supa::Representable

    define do
      namespace :jsonapi do
        virtual :version, getter: 1.1, modifier: :to_s
      end

      namespace :meta do
        attribute :locale, getter: :language, exec_context: :representer
        attribute :date, exec_context: :representer
      end

      collection :data, getter: :itself, render_empty: true do
        attribute :id
        virtual :type, getter: 'articles'

        namespace :attributes do
          attribute :title
          attribute :text
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

      collection :included, getter: :authors, exec_context: :representer do
        attribute :id
        virtual :type, getter: 'authors'

        namespace :attributes do
          attribute :first_name
          attribute :last_name
        end
      end

      append :included, getter: :comments, exec_context: :representer do
        attribute :id
        virtual :type, getter: 'comments'

        namespace :attributes do
          attribute :text
        end
      end
    end

    def authors
      representee.flat_map(&:authors).uniq
    end

    def comments
      representee.flat_map(&:comments).uniq
    end

    def to_s(value)
      value.to_s
    end

    def language
      'en'
    end

    def date
      Date.today.iso8601
    end
  end
end
