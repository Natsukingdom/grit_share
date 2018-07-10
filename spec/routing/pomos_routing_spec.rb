require 'rails_helper'

RSpec.describe PomosController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/pomos').to route_to('pomos#index')
    end

    it 'routes to #new' do
      expect(get: '/pomos/new').to route_to('pomos#new')
    end

    it 'routes to #show' do
      expect(get: '/pomos/1').to route_to('pomos#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/pomos/1/edit').to route_to('pomos#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/pomos').to route_to('pomos#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/pomos/1').to route_to('pomos#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/pomos/1').to route_to('pomos#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/pomos/1').to route_to('pomos#destroy', id: '1')
    end
  end
end
