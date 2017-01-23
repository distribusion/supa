require 'spec_helper'

describe Supa::Representable do
  let(:article) { Supa::Fixtures.article }
  let(:author) { article.author }
  let(:comments) { article.comments }
  let(:representer) { Supa::ArticleRepresenter.new(article) }

  describe '.define' do
    let(:represented) do
      {
        jsonapi: {version: '1.1'},
        meta: {
          locale: 'en',
          date: Date.today.iso8601
        },
        data: {
          id: article.id,
          type: 'articles',
          attributes: {
            title: article.title,
            text: article.text
          },
          relationships: {
            author: {
              data: {id: author.id, type: 'authors'}
            },
            comments: {
              data: [
                {id: comments[0].id, type: 'comments'},
                {id: comments[1].id, type: 'comments'}
              ]
            }
          }
        },
        included: [
          {
            id: author.id,
            type: 'authors',
            attributes: {
              first_name: author.first_name,
              last_name: author.last_name
            }
          },
          {
            id: comments[0].id,
            type: 'comments',
            attributes: {
              text: comments[0].text
            }
          },
          {
            id: comments[-1].id,
            type: 'comments',
            attributes: {
              text: comments[-1].text
            }
          }
        ]
      }
    end

    subject { representer }

    describe '#to_hash' do
      it 'serializes to hash' do
        expect(subject.to_hash).to eq(represented)
      end
    end

    describe '#to_json' do
      it 'serializes to hash' do
        expect(subject.to_json).to eq(represented.to_json)
      end
    end

    context 'when object is nil' do
      let(:article) { nil }
      let(:represented) do
        {
          jsonapi: {version: '1.1'},
          meta: {
            locale: 'en',
            date: Date.today.iso8601
          },
          data: {}
        }
      end

      describe '#to_hash' do
        it 'serializes to hash' do
          expect(representer.to_hash).to eq(represented)
        end
      end
    end

    context 'when object is empty array' do
      let(:articles) { [] }
      let(:represented) do
        {
          jsonapi: {version: '1.1'},
          meta: {
            locale: 'en',
            date: Date.today.iso8601
          },
          data: []
        }
      end
      subject(:representer) { Supa::ArticlesRepresenter.new(articles) }

      describe '#to_hash' do
        it 'serializes to hash' do
          expect(representer.to_hash).to eq(represented)
        end
      end
    end
  end
end
