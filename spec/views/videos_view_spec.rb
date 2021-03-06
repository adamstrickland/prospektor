require 'spec_helper'

describe 'videos at' do
  describe '/views' do
    describe '/videos' do
      describe '/player' do
        # it 'with a title' do
        #   title = 'Somethign'
        #   assigns[:title] = title
        #   render('/videos/player.html.haml')
        #   response.should have_tag('head title', title)
        # end
        
        it 'renders using partial' do
          template.should_receive(:render).with(:partial => 'player_config')
          render '/videos/player.html.haml'
        end
        
        it 'with a key' do
          @url = Faker::Internet.domain_name
          key = 'OU9w7inLLKiu'
          assigns[:video] = stub_model(Video)
          assigns[:bindings] = { :key => key }
          assigns[:video_json_url] = @url
          render('/videos/_player_config.html.haml')
          response.should have_tag('script', /^.*#{@url}.*$/)
          # response.body.should match(/^.*#{key}.*$/)
        end
        
        
      end
    end
  end
end