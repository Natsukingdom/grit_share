require 'rails_helper'

RSpec.describe PomosController, type: :routing do
  describe 'routing' do
    let(:user) { create(:user) }
    let(:pomo) { create(:pomo) }
    it 'routes to #index' do
      expect(get: "/users/#{user.id}/pomos").to route_to('pomos#index', user_id: '2')
    end

    it 'routes to #new' do
      expect(get: "/users/#{user.id}/pomos/new").to route_to('pomos#new', user_id: '2')
    end

    it 'routes to #show' do
      expect(get: "/users/#{user.id}/pomos/#{pomo.id}").to route_to('pomos#show', id: pomo.id.to_s, user_id: '2')
    end

    it 'routes to #edit' do
      expect(get: "/users/#{user.id}/pomos/1/edit").to route_to('pomos#edit', id: '1', user_id: '2')
    end

    it 'routes to #create' do
      expect(post: "/users/#{user.id}/pomos").to route_to('pomos#create', user_id: '2')
    end

    it 'routes to #update via PUT' do
      expect(put: "/users/#{user.id}/pomos/1").to route_to('pomos#update', id: '1', user_id: '2')
    end

    it 'routes to #update via PATCH' do
      expect(patch: "/users/#{user.id}/pomos/1").to route_to('pomos#update', id: '1', user_id: '2')
    end

    it 'routes to #destroy' do
      expect(delete: "/users/#{user.id}/pomos/1").to route_to('pomos#destroy', id: '1', user_id: '2')
    end
  end
end
