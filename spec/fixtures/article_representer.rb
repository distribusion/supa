module Supa
  class ArticleRepresenter
    include Supa::Representable

    define do
      namespace :jsonapi do
        attribute :version, getter: proc { 1.1 }
      end

      namespace :data do
        attribute :id
        attribute :type, getter: proc { 'articles' }

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
            collection :data, getter: proc { self.comments } do
              attribute :id
              attribute :type, getter: proc { 'comments' }
            end
          end
        end
      end

      collection :included, append: true, getter: proc { [self.author] } do
        attribute :id
        attribute :type, getter: proc { 'authors' }

        namespace :attributes do
          attribute :first_name
          attribute :last_name
        end
      end

      collection :included, append: true, getter: proc { self.comments } do
        attribute :id
        attribute :type, getter: proc { 'comments' }

        namespace :attributes do
          attribute :text
        end
      end
    end
  end
end
